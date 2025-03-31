local wezterm = require 'wezterm'
local config = {}
config.font = wezterm.font 'Fira Code'

config.color_scheme = "Ayu Mirage"
config.color_scheme_dirs = { '/home/vport/.wezterm/' }
config.window_decorations = 'NONE'
config.enable_tab_bar = false
config.default_prog = { '/usr/bin/zsh'}
config.front_end = "WebGpu"
config.max_fps = 240

return config
