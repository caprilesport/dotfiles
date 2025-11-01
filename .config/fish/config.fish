if status is-interactive
    if set -q SSH_LOGIN[1] || not set -q ENV[1]
        bass "source ~/.profile"
    end

    #fish options
    set -U fish_greeting

    # utilities that need to be sourced
    fzf --fish | source
    set -x FZF_DEFAULT_OPTS "--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"

    # eval (ssh-agent -c)
    # ssh-add ~/.ssh/id_ed25519

    # activate a venv by default
    source ~/projects/scripts/.venv/bin/activate.fish

    zoxide init fish | source
    starship init fish | source

    # Commands to run in interactive sessions can go here
    # bind ctrl-alt-j 'echo "Binding triggered"; ~/projects/scripts/tmux-sessionizer'
    # bind \c\aj '~/projects/scripts/tmux-sessionizer'
    atuin init fish --disable-up-arrow | source

    export XCURSOR_THEME="Qogir-dark"
    # export XCURSOR_SIZE="24" # Adjust size as needed, e.g., 16, 32, 48
end
