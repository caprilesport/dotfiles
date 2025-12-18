local wezterm = require 'wezterm'
local config = {}
config.font = wezterm.font 'Fira Code'
config.font_size = 13

config.color_scheme = "Catppuccin Mocha"
config.color_scheme_dirs = { '/home/vport/.config/wezterm/colors' }
-- config.window_decorations = 'NONE'
config.enable_tab_bar = false
config.default_prog = { '/usr/bin/fish'}
-- config.front_end = "WebGpu"
config.max_fps = 240
config.window_background_opacity = 0.95


local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-theme"})
if success then
  config.xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
end

local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-size"})
if success then
  config.xcursor_size = tonumber(stdout)
end

-- wezterm.on("gui-startup",
--    function(cmd)
--       local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
--       -- Maximise before toggling full screen:
--       window:gui_window():maximize()
--       window:gui_window():toggle_fullscreen()
-- end
-- )

-- disable most of the keybindings because tmux can do that.
-- in fact, I'm disabling all of them here and just allowing the few I want
config.disable_default_key_bindings = true

local act = wezterm.action

config.keys = {

{ key = ")",        mods = "CTRL",  action = act.ResetFontSize },

{ key = "-",        mods = "CTRL",  action = act.DecreaseFontSize },

{ key = "=",        mods = "CTRL",  action = act.IncreaseFontSize },

{ key = "N",        mods = "CTRL",  action = act.SpawnWindow },

{ key = "P",        mods = "CTRL",  action = act.ActivateCommandPalette },

{ key = "V",        mods = "CTRL",  action = act.PasteFrom("Clipboard") },

{ key = "Copy",     mods = "NONE",  action = act.CopyTo("Clipboard") },

{ key = "Paste",    mods = "NONE",  action = act.PasteFrom("Clipboard") },

{ key = "F11",      mods = "NONE",  action = act.ToggleFullScreen },

}

return config

