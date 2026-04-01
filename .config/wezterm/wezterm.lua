local wezterm = require("wezterm")
local config = {}
local act = wezterm.action

config.debug_key_events = true
config.enable_wayland = false

config.scrollback_lines = 3500

config.font = wezterm.font("Fira Code")
config.font_size = 12

config.color_scheme = "Catppuccin Mocha"
config.color_scheme_dirs = { "/home/vport/.config/wezterm/colors" }

config.enable_tab_bar = true
config.default_prog = { "/usr/bin/fish" }
config.front_end = "OpenGL"
config.max_fps = 120
config.window_background_opacity = 0.9

config.xcursor_theme = "Bibata-modern-ice"
config.xcursor_size = 22

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{ key = "t", mods = "LEADER", action = wezterm.action.ShowTabNavigator },
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Rename tab:",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = ".",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Rename workspace:",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					wezterm.mux.rename_workspace(
						window:active_workspace(),
						line
					)
				end
			end),
		}),
	},
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = act.SendKey({ key = "a", mods = "CTRL" }),
	},
}

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelectionOrOpenLinkAtMouseCursor(
			"ClipboardAndPrimarySelection"
		),
	},
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("Line"),
		mods = "NONE",
	},
}

require("navigation").apply(config)
require("sessions").apply(config)
require("ui").apply(config)

return config
