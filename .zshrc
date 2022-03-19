#!/usr/bin/env bash
# aliases and enviroment variables
source ~/.alias
source ~/.env

# Path to oh-my-zsh installation.
export ZSH="/home/vport/.oh-my-zsh"
HIST_STAMPS="dd/mm/yyyy"  

#Plugins
plugins=(
  fd
  fnm
  gh
  git
  git-extras
  golang
  nmap
  node
  npm
  pip
  poetry
  pyenv
  python
  ripgrep
  rsync
  rust
  ubuntu

  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

source /home/vport/.config/broot/launcher/bash/br
source ~/.fzf/shell/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias ls="lsd"
