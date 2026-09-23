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
$env.config.completions.partial = true
$env.config.completions.algorithm = "fuzzy"
$env.config.auto_cd_implicit = true
$env.config.table.index_mode = "auto"
$env.config.footer_mode = "auto"
$env.config.history.file_format = "sqlite"
$env.config.highlight_resolved_externals = true
$env.config.use_kitty_protocol = true
$env.OPAL_PREFIX = "/opt/openmpi-4.1.8"
$env.config.table.mode = "light"
$env.LS_COLORS = (vivid generate nord)
$env.config.edit_mode = "helix"
$env.VIRTUAL_ENV_DISABLE_PROMPT = 1

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
source ./utils.nu

# cli
source ~/.zoxide.nu
use ./conda.nu
source $"($nu.cache-dir)/carapace.nu"

#  Wrap Carapace and fall back to a small path completer that can match anywhere in the filename.
let carapace_external_completer = $env.config.completions.external.completer

$env.config.completions.external.completer = {|spans|
    let carapace_results = (do $carapace_external_completer $spans)
    if ($carapace_results | is-empty) {
        partial-path-completions ($spans | last)
    } else {
        $carapace_results
    }
}
