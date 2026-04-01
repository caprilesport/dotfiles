local wezterm = require("wezterm")
local act = wezterm.action

local function navigate_or_tab(pane_direction, tab_direction)
	return wezterm.action_callback(function(window, pane)
		local tab = window:active_tab()
		local all_panes = tab:panes_with_info()
		local current_pane_id = pane:pane_id()

		local current_pane = nil
		for _, pane_info in ipairs(all_panes) do
			if pane_info.pane:pane_id() == current_pane_id then
				current_pane = pane_info
				break
			end
		end

		local at_edge = true
		if current_pane then
			local tab_width = 0
			for _, pane_info in ipairs(all_panes) do
				local right_edge = pane_info.left + pane_info.width
				if right_edge > tab_width then
					tab_width = right_edge
				end
			end

			if pane_direction == "Left" then
				at_edge = current_pane.left == 0
			elseif pane_direction == "Right" then
				at_edge = (current_pane.left + current_pane.width) >= tab_width
			end
		end

		if at_edge then
			window:perform_action(act.ActivateTabRelative(tab_direction), pane)
		else
			window:perform_action(
				act.ActivatePaneDirection(pane_direction),
				pane
			)
		end
	end)
end

local M = {}

function M.apply(config)
	local keys = config.keys or {}
	for _, binding in ipairs({
		-- Pane navigation with Alt+hjkl, wrapping to adjacent tab at horizontal edges
		{ key = "h", mods = "ALT", action = navigate_or_tab("Left", -1) },
		{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "ALT", action = navigate_or_tab("Right", 1) },

		-- Zoom current pane
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

		-- Pane splitting
		{
			key = "u",
			mods = "LEADER",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
	}) do
		table.insert(keys, binding)
	end
	config.keys = keys
end

return M
