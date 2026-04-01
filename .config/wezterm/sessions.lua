local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

-- Project list: label = workspace name, id = root directory
M.projects = {
	{ label = "litio", id = "~/projects/litio" },
	{ label = "chem-utils", id = "~/projects/chem-utils" },
	{ label = "recli", id = "~/projects/recli" },
	{ label = "gedent", id = "~/projects/gedent" },
	{ label = "curiculo", id = "~/projects/curiculo" },
	{ label = "ugi", id = "~/projects/doc/ugi" },
	{ label = "agh", id = "~/projects/doc/agrh" },
	{ label = "scripts", id = "~/projects/scripts" },
	{ label = "wezterm", id = "~/.config/wezterm" },
	{ label = "helix", id = "~/.config/helix" },
}

local workspace_dirs = {}
for _, p in ipairs(M.projects) do
	workspace_dirs[p.label] = p.id
end

local function expand(path)
	return (path:gsub("^~", os.getenv("HOME")))
end

local shell = os.getenv("SHELL") or "/usr/bin/fish"

-- fish's config.fish can override CWD after WezTerm sets it.
-- Using -C runs a command after init scripts, so the cd sticks.
local function spawn_in_dir(dir)
	if shell:find("fish") then
		return { args = { shell, "-C", "cd " .. dir } }
	end
	return { cwd = dir }
end

-- Switch to any project (creates workspace if needed)
local function switch_workspace()
	return wezterm.action_callback(function(window, pane)
		window:perform_action(
			act.InputSelector({
				title = "Open project",
				choices = M.projects,
				fuzzy = true,
				action = wezterm.action_callback(function(win, pn, id, label)
					if not id then
						return
					end
					win:perform_action(
						act.SwitchToWorkspace({
							name = label,
							spawn = spawn_in_dir(expand(id)),
						}),
						pn
					)
				end),
			}),
			pane
		)
	end)
end

-- Switch between already-active workspaces
local function switch_active()
	return wezterm.action_callback(function(window, pane)
		local names = wezterm.mux.get_workspace_names()
		local choices = {}
		for _, name in ipairs(names) do
			table.insert(choices, { label = name, id = name })
		end
		window:perform_action(
			act.InputSelector({
				title = "Active sessions",
				choices = choices,
				fuzzy = true,
				action = wezterm.action_callback(function(win, pn, id, _)
					if not id then
						return
					end
					win:perform_action(act.SwitchToWorkspace({ name = id }), pn)
				end),
			}),
			pane
		)
	end)
end

-- New tab in the current workspace's project root
local function new_tab()
	return wezterm.action_callback(function(window, pane)
		local dir = workspace_dirs[window:active_workspace()]
		if dir then
			window:perform_action(
				act.SpawnCommandInNewTab(spawn_in_dir(expand(dir))),
				pane
			)
		else
			window:perform_action(act.SpawnTab("CurrentPaneDomain"), pane)
		end
	end)
end

-- Background tasks: each spawns a new window
-- args: direct exec for simple commands; use shell for commands with && or ;
local bg_tasks = {
	{ label = "yay update",  args = { "yay" } },
	{ label = "btop",        args = { "btop" } },
}

local function pick_background_task()
	local choices = {}
	local task_map = {}
	for _, t in ipairs(bg_tasks) do
		table.insert(choices, { label = t.label, id = t.label })
		task_map[t.label] = t.args
	end
	return wezterm.action_callback(function(window, pane)
		window:perform_action(
			act.InputSelector({
				title = "Run background task",
				choices = choices,
				fuzzy = true,
				action = wezterm.action_callback(function(win, pn, id, _)
					if not id then return end
					win:perform_action(
						act.SpawnCommandInNewWindow({ args = task_map[id] }),
						pn
					)
				end),
			}),
			pane
		)
	end)
end

-- Prompt for a name and create a new blank workspace
local function new_workspace()
	return act.PromptInputLine({
		description = "New workspace name:",
		action = wezterm.action_callback(function(window, pane, name)
			if name and #name > 0 then
				window:perform_action(
					act.SwitchToWorkspace({ name = name }),
					pane
				)
			end
		end),
	})
end

function M.apply(config)
	local keys = config.keys or {}
	for _, binding in ipairs({
		{ key = "j", mods = "LEADER", action = switch_workspace() },
		{ key = "s", mods = "LEADER", action = switch_active() },
		{ key = "c", mods = "LEADER", action = new_tab() },
		{ key = "n", mods = "LEADER", action = new_workspace() },
		{ key = "b", mods = "LEADER", action = pick_background_task() },
	}) do
		table.insert(keys, binding)
	end
	config.keys = keys
end

return M
