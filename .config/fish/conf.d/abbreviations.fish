#shortcuts
abbr -a :q exit
abbr -a :! exit
abbr -a tf 'tail -f'
abbr -a - "z -"
abbr -a ... "cd ../../"
abbr -a .... "cd ../../../"
abbr -a ..... "cd ../../../../"
abbr -a --set-cursor awkp "awk '{print \$%}'"
abbr -a tms tmux-sessionizer
abbr -a fgj "fg (jobs | fzf | awk '{print \$2}')"

abbr -a --set-cursor litio "litio % --background white"

# clusters
abbr -a babel 'ssh -t babel "fish -l"'
abbr -a qsj 'ssh jupiter "qstat"'
abbr -a qsv 'ssh jupiter "qstat" -u vport'
abbr -a qsb 'ssh -t babel "pueue"'
abbr -a qsl 'ssh loboc "qstat"'
abbr -a qsn 'ssh newton "squeue"'
abbr -a pq pueue
abbr -a pqn "cd (ssh pipeline \"pueue status -j\" | jq '.tasks.[].path' | tr -d '\"' | head -n1)"
abbr -a jupfree "ssh jupiter \"pbsnodes -aSj | grep -E '8\\/8|16\\/16' | sort -k1 | awk '{print \\\$1}'\""
abbr -a qdelloboc 'ssh loboc "qdel"'
abbr -a qdeljup 'ssh jupiter "qdel"'
abbr -a qdelnew 'ssh newton "scancel"'
abbr -a qdelbabel 'ssh babel "pueue remove $1"'
abbr -a geemloboc 'ssh loboc "qstat" | rg "vport|mrauen|krauskopf|famorim|viniglitz"'

# system
abbr -a update 'sudo pacman -Syyu'
abbr -a mkdir 'mkdir -p'
abbr -a reload 'exec fish'
abbr -a fakevpn 'sudo tailscale set --exit-node=trindatimes'
abbr -a exitfakevpn 'sudo tailscale up --exit-node='
abbr -a update-arch-mirrors 'rate-mirrors --disable-comments-in-file --entry-country=BR --protocol=https arch --max-delay 7200 | sudo tee /etc/pacman.d/mirrorlist'
abbr -a update-eos-mirrors 'rate-mirrors --disable-comments-in-file --entry-country=BR --protocol=https endeavouros  | sudo tee /etc/pacman.d/endeavouros-mirrorlist'
abbr -a activateagent 'eval (ssh-agent -c) && ssh-add ~/.ssh/id_ed25519'
abbr -a getid "(recli status --show-id | fzf | awk '{print \$(NF)}')"
abbr -a recli-ids "recli status --show-id | fzf  -m | awk '{print \$(NF)}'"
abbr -a orca-normal 'rg "ORCA TERMINATED NORMALLY" --files-with-matches *.out '

# programs 
abbr -a ipy ipython
abbr -a lg lazygit
abbr -a cp 'cp -r'
abbr -a ggen 'gedent gen (gedent template list | fzf) '
abbr -a periodic-table 'npx periodic-table-cli'
abbr -a yadmgui 'yadm enter gitui'
abbr -a --set-cursor rnr 'rnr regex --no-dump % * -f'
abbr -a rg "rg -j1"

# ledger abbr -a
abbr -a hled hledger

# lsd
abbr -a l ls
abbr -a --set-cursor ls 'eza --icons auto'
abbr -a --set-cursor ll 'eza -l --icons auto'
abbr -a --set-cursor la 'eza -a --icons auto'
abbr -a --set-cursor lla 'eza -la --icons auto'
abbr -a --set-cursor lt 'eza --tree --icons auto'

abbr -a cat bat
# abbr -a cd z

#cargo
abbr -a cargoclippy 'cargo clippy --fix --allow-dirty --allow-staged -- -W clippy::pedantic -W clippy::nursery'

# git 
abbr -a g git
abbr -a gf 'git diff --name-only'
abbr -a gac 'git a . && git c "updates" && git ps'

#scripts environment
abbr -a pyenv '. ~/projects/scripts/.venv/bin/activate.fish'

# orca stuff
abbr -a energy 'grep -i "final gibbs free energy" **/*.out'
abbr -a imfreq 'grep -i "imaginary mode" **/*.out'
abbr -a geomcycle 'grep -i "geometry optimization cycle" **/*.out'
abbr -a scanprogress 'grep -i "RELAXED SURFACE SCAN STEP" **/*.out'

# other
abbr -a cs csync
abbr -a up 'cd (parent-dirs | fzf)'
abbr -a rmfilter 'rm (ls | rg -v (string trim -c "|" (for i in (ls | fzf -m); echo -n "$i|"; end)))'
abbr -a addjob 'pueue add -- job init.inp'
