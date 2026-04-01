export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

#allow less to scroll with mouse
export LESS="--mouse --wheel-lines=3"

. "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.npm-global/lib:$PATH"

# some software 
export PATH="$HOME/software:$PATH"
export PATH="$HOME/projects/scripts:$PATH" # my scripts

export PATH="$HOME/software/blender-5:$PATH"
export PATH="$HOME/software/vmd-2:$PATH"
export PATH="$HOME/software/vmd:$PATH"

#path xtb/crest
export XTBHOME="$HOME/software/xtb"
export PATH="$HOME/software/crest:$PATH"
export PATH="$HOME/software/xtb/bin:$PATH" # some programs

export GXTBHOME="$HOME/software/gxtb"
export PATH="$HOME/software/gxtb:$PATH"

#nbo
export NBOEXE="$HOME/software/nbo7/bin/nbo7.i4.exe"

#git 
export GCM_CREDENTIAL_STORE=cache

# orca 
export PATH="$HOME/software/orca_6_0_1:$PATH"
export PATH="$HOME/software/orca_5_0_4:$PATH"
export LD_LIBRARY_PATH="$HOME/software/orca_6_0_1:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOME/software/orca_5_0_4:$LD_LIBRARY_PATH"
export PATH="/opt/openmpi-4.1.1/bin/:$PATH"
export LD_LIBRARY_PATH="/opt/openmpi-4.1.1/lib:$LD_LIBRARY_PATH"

export PATH="$HOME/software/xtb-6.6.1/bin:$PATH" # some programs
# go 
export GOPATH="$HOME/projects"
export GOPATH="$HOME/go:$GOPATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$GOPATH/bin"

# mlr colors
export MLR_VALUE_COLOR=117
export MLR_KEY_COLOR=112

#rio
export COLORTERM=truecolor

#steel
export STEEL_HOME="$HOME/.steel"
export STEEL_LSP_HOME="$HOME/.config/steel-lsp/"

# fzf
export FZF_DEFAULT_OPTS="--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"
#set hx as preferred editor
export EDITOR=$HOME/.cargo/bin/hx
export VISUAL=$HOME/.cargo/bin/hx

export LEDGER_FILE=~/Finances/2025.journal #ledger journal

export ZK_NOTEBOOK_DIR="$HOME/notes/"

#gromacs
# if [[ $(hostname) == "pipeline" ]]; then
# 	source /opt/gromacs/bin/GMXRC
# elif [[ $(hostname) == "trindatimes" ]]; then 
# 	source /usr/local/gromacs/bin/GMXRC
# fi

# my python lib
# export PYTHONPATH=$PYTHONPATH:$HOME/projects/lib/

# secret :)
source "$HOME/.secrets"

. "$HOME/.atuin/bin/env"


