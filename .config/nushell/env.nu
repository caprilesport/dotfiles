# env.nu
#
# Installed by:
# version = "0.115.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.



# Import shared POSIX login exports; do not run interactive Bash/Flyline.
let shared_environment = (^/usr/bin/bash --noprofile --norc -c 'source "$HOME/.profile" >/dev/null; /usr/bin/python3 -c "import json, os; print(json.dumps(dict(os.environ)))"' | from json | reject --optional SHLVL _ PWD OLDPWD SHELL FILE_PWD CURRENT_FILE)
load-env $shared_environment
$env.PATH = ($env.PATH | split row (char esep) | uniq)

# Match the ORCA 6 / OpenMPI 4.1.8 overrides in ~/.bashrc.
$env.OPAL_PREFIX = '/opt/openmpi-4.1.8'
$env.OMPI_MCA_component_path = '/opt/openmpi-4.1.8/lib/openmpi'
$env.PATH = (['/opt/openmpi-4.1.8/bin' ($env.HOME | path join 'software/orca_6_1_1')] | append $env.PATH | uniq)
$env.LD_LIBRARY_PATH = (['/opt/openmpi-4.1.8/lib' ($env.HOME | path join 'software/orca_6_1_1')] | append (($env.LD_LIBRARY_PATH? | default '') | split row (char esep) | where {|p| $p != ''}) | uniq | str join (char esep))

zoxide init nushell | save -f ~/.zoxide.nu

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
