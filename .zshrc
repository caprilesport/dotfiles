#!/usr/bin/env bash
# aliases and enviroment variables
fpath=(~/.zsh/ $fpath)
source ~/.alias
source ~/.env

# Path to oh-my-zsh installation.
export ZSH="/home/vport/.oh-my-zsh"
HIST_STAMPS="dd/mm/yyyy"  

#Plugins
plugins=(
  archlinux
  fd
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
  poetry
  pyenv
  python
  ripgrep
  rsync
  rust

  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

source "$HOME/.config/broot/launcher/bash/br"
source "$HOME/.fzf/shell/key-bindings.zsh"

[ -f "/home/vport/.ghcup/env" ] && source "/home/vport/.ghcup/env" # ghcup-env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias ls="lsd"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt autocd extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vport/.zshrc'

autoload -Uz compinit
compinit
xrandr --output HDMI-0 --above DP-1
# End of lines added by compinstall
