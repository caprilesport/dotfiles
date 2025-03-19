#!/usr/bin/env bash
# aliases and enviroment variables
fpath=(~/.zsh/ $fpath)
source ~/.alias
source ~/.env
source ~/.functions

# Path to oh-my-zsh installation.
export ZSH="/home/vport/.oh-my-zsh"
HIST_STAMPS="dd/mm/yyyy"  

#Plugins
plugins=(
  archlinux
  fnm
  gh
  git
  gitfast
  git-extras
  golang
  nmap
  node
  npm
  pip
  pyenv
  python
  rsync
  rust
  uv

  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

source "$HOME/.config/broot/launcher/bash/br"
source "$HOME/.fzf/shell/key-bindings.zsh"


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000000
SAVEHIST=50000000
setopt autocd extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vport/.zshrc'

autoload -Uz compinit
compinit
alias ls='eza --icons=auto'

source /home/vport/.config/broot/launcher/bash/br

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ORCA 6.0.0 secion
export PATH=/home/vport/orca_6_0_0:$PATH


fpath+=~/.zfunc; autoload -Uz compinit; compinit
eval "$(uv generate-shell-completion zsh)"

