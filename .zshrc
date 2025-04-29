#!/usr/bin/env bash
# aliases and enviroment variables
fpath+=~/.zsh
fpath+=~/.zfunc
source ~/.alias
source ~/.env
source ~/.functions

# Path to oh-my-zsh installation.
export ZSH="/home/vport/.oh-my-zsh"
HIST_STAMPS="dd/mm/yyyy"  

#Plugins
plugins=(
  archlinux
  gh
  git
  gitfast
  git-extras
  pip
  python
  rust

  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

source "$HOME/.fzf/shell/key-bindings.zsh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

setopt autocd extendedglob
unsetopt beep
bindkey -e
bindkey -s "^f" "tmux-sessionizer\n"

alias ls='eza --icons=auto'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ORCA 6.0.0 secion
export PATH=/home/vport/orca_6_0_0:$PATH

autoload -Uz compinit
compinit
