local wezterm = require 'wezterm'
local config = {}
config.font = wezterm.font 'JetBrains Mono'

config.color_scheme = "Gruvbox Dark (Gogh)"
config.color_scheme_dirs = { '/home/vport/.wezterm/' }
config.window_decorations = 'NONE'
config.enable_tab_bar = false
config.default_prog = { '/usr/bin/zsh'}

return config
