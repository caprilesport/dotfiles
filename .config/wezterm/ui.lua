local wezterm = require("wezterm")

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local M = {}

-- Catppuccin Mocha palette
local p = {
	base = "#1e1e2e",
	mantle = "#181825",
	surface0 = "#313244",
	surface1 = "#45475a",
	overlay0 = "#6c7086",
	subtext0 = "#a6adc8",
	text = "#cdd6f4",
	blue = "#89b4fa",
	mauve = "#cba6f7",
	green = "#a6e3a1",
	peach = "#fab387",
	yellow = "#f9e2af",
	teal = "#94e2d5",
}

-- Workspace badge cycles through accent colors based on name
local workspace_palette =
	{ p.mauve, p.blue, p.green, p.peach, p.teal, p.yellow }

local function workspace_color(name)
	local hash = 0
	for i = 1, #name do
		hash = (hash * 31 + string.byte(name, i)) % #workspace_palette
	end
	return workspace_palette[hash + 1]
end

local process_names = {
	hx    = wezterm.nerdfonts.md_dna .. " hx",
	helix = wezterm.nerdfonts.md_dna .. " hx",
}

local function tab_title(tab, max_width)
	local title
	if tab.tab_title and #tab.tab_title > 0 then
		title = tab.tab_title
	else
		local proc = tab.active_pane.foreground_process_name
		local basename = (proc and proc:match("([^/]+)$"))
			or tab.active_pane.title:match("^(%S+)")
			or ""
		title = process_names[basename] or tab.active_pane.title
	end

	local prefix = " "
	local suffix = " "
	local avail = max_width
		- wezterm.column_width(prefix)
		- wezterm.column_width(suffix)
		- 2 -- arrow caps
	if wezterm.column_width(title) > avail then
		title = wezterm.truncate_right(title, avail)
	end
	return prefix .. title .. suffix
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
	local label = tab_title(tab, max_width)

	if tab.is_active then
		return {
			{ Background = { Color = p.mantle } },
			{ Foreground = { Color = p.blue } },
			{ Text = SOLID_LEFT_ARROW },
			{ Background = { Color = p.blue } },
			{ Foreground = { Color = p.base } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = label },
			{ Background = { Color = p.mantle } },
			{ Foreground = { Color = p.blue } },
			{ Text = SOLID_RIGHT_ARROW },
		}
	end

	local bg = hover and p.surface1 or p.surface0
	local fg = hover and p.text or p.subtext0
	return {
		{ Background = { Color = p.mantle } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = label },
		{ Background = { Color = p.mantle } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

wezterm.on("update-status", function(window, _)
	local workspace = window:active_workspace()
	local color = workspace_color(workspace)

	window:set_left_status(wezterm.format({
		{ Background = { Color = color } },
		{ Foreground = { Color = p.base } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = "  " .. workspace .. " " },
		{ Background = { Color = p.mantle } },
		{ Foreground = { Color = color } },
		{ Text = "\u{E0B0}" }, -- powerline right arrow
	}))

	window:set_right_status(wezterm.format({
		{ Background = { Color = p.mantle } },
		{ Foreground = { Color = p.surface0 } },
		{ Text = "\u{E0B2}" }, -- powerline left arrow
		{ Background = { Color = p.surface0 } },
		{ Foreground = { Color = p.subtext0 } },
		{ Text = wezterm.strftime(" %Y-%m-%d %H:%M ") },
	}))
end)

function M.apply(config)
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.tab_max_width = 32
	config.hide_tab_bar_if_only_one_tab = false
	config.show_new_tab_button_in_tab_bar = false

	-- Breathing room inside the window
	config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }

	-- Dim inactive panes to highlight the active one
	config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.65 }

	config.colors = {
		split = p.surface1,
		tab_bar = {
			background = p.mantle,
			active_tab = {
				bg_color = p.blue,
				fg_color = p.base,
				intensity = "Bold",
			},
			inactive_tab = { bg_color = p.surface0, fg_color = p.subtext0 },
			inactive_tab_hover = { bg_color = p.surface1, fg_color = p.text },
			new_tab = { bg_color = p.mantle, fg_color = p.overlay0 },
			new_tab_hover = { bg_color = p.surface0, fg_color = p.text },
		},
	}
end

return M
