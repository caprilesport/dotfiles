# config.nu
#
# Installed by:
# version = "0.115.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

use std/dirs

$env.config.buffer_editor = "hx"
$env.config.show_banner = false
$env.config.rm.always_trash = true
$env.config.completions.algorithm = "substring"
$env.config.auto_cd_implicit = true
$env.config.table.index_mode = "auto"
$env.config.footer_mode = "auto"
$env.config.history.file_format = "sqlite"
$env.config.highlight_resolved_externals = true
 $env.config.use_kitty_protocol = true

$env.config.edit_mode = "helix"

 $env.config.keybindings ++= [{
     name: fzf_file
     modifier: control_alt
     keycode: char_f
     mode: [emacs vi_insert helix_insert]
     event: {
         send: executehostcommand
         cmd: 'let file = (^fd --type f | ^fzf | str trim); if $file != "" { commandline edit --insert ($file | to nuon) }'
     }
 }]

# modules
source ./abbr.nu
source ./functions.nu

# cli
source ~/.zoxide.nu
use ./conda.nu
