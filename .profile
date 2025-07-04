. "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/projects/scripts:$PATH" # my scripts
export LEDGER_FILE=~/Finances/2025.journal #ledger journal
export PATH="/opt:$PATH" # some programs
export PATH="/opt/xtb/bin:$PATH" # some programs
. "$HOME/.cargo/env" # rust package manager

# local and remote directories roots
export LOCAL_PROJECTS="/home/vport/projects"
export JUPITER_PROJECTS="/scratch/vport/projects"
export LOBOC_PROJECTS="/scratch/01032a/vport"
export NEWTON_PROJECTS="/scratch/vport"

#set hx as preferred editor
export EDITOR=$HOME/.cargo/bin/hx
export VISUAL=$HOME/.cargo/bin/hx

# some software 
export PATH="$HOME/software:$PATH"

#git 
export GCM_CREDENTIAL_STORE=cache

#path xtb
export XTBHOME="/opt/xtb"

# orca 
export PATH="/home/vport/software/orca_6_0_1:$PATH"
export LD_LIBRARY_PATH="/home/vport/software/orca_6_0_1:$LD_LIBRARY_PATH"

# openmpi
export PATH="/opt/openmpi-4.1.6/bin:$PATH"
export LD_LIBRARY_PATH="/opt/openmpi-4.1.6/lib:$LD_LIBRARY_PATH"

# go 
export GOPATH="$HOME/repos"
export GOPATH="$HOME/go:$GOPATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/home/vport/go/bin"
export PATH="$PATH:$GOPATH/bin"

# juliaup
export PATH="$PATH:/home/vport/.juliaup/bin"

#steel
export STEEL_HOME="$HOME/.steel"
export STEEL_LSP_HOME="$HOME/.config/steel-lsp/"

export FZF_DEFAULT_OPTS="--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"

#gromacs
if [[ $(hostname) == "pipeline" ]]; then
	source /opt/gromacs/bin/GMXRC
elif [[ $(hostname) == "trindatimes" ]]; then 
	source /usr/local/gromacs/bin/GMXRC
fi

# mlr colors
export MLR_VALUE_COLOR=117
export MLR_KEY_COLOR=112

# secret :)
source "$HOME/.secrets"

. "$HOME/.atuin/bin/env"
. "/home/vport/.deno/env"
