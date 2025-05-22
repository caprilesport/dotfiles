if status is-interactive
    #fish options
    set -U fish_greeting

    # utilities that need to be sourced
    fzf --fish | source
    set -x FZF_DEFAULT_OPTS "--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"

    zoxide init fish | source
    starship init fish | source

    # Commands to run in interactive sessions can go here
    bind \cf tmux-sessionizer
end
