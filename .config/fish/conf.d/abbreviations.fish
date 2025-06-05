#shortcuts
abbr -a :q exit
abbr -a :! exit
abbr -a tf 'tail -f'

# clusters
abbr -a qsj 'ssh jupiter "qstat"'
abbr -a qsp 'ssh -t pipeline "pueue"'
abbr -a qsl 'ssh loboc "qstat"'
abbr -a pq pueue
abbr -a pqn "cd (ssh pipeline \"pueue status -j\" | jq '.tasks.[].path' | tr -d '\"' | head -n1)"
abbr -a jupfree "ssh jupiter \"pbsnodes -aSj | grep -E '8\\/8|16\\/16' | sort -k1 | awk '{print \\\$1}'\""
abbr -a qdelloboc 'ssh loboc "qdel"'
abbr -a qdeljup 'ssh jupiter "qdel"'
abbr -a qdelpipe 'ssh pipeline "pueue remove $1"'

# system
abbr -a update 'sudo pacman -Syyu'
abbr -a mkdir 'mkdir -p'
abbr -a reload 'source ~/.config/fish/config.fish'
abbr -a fakevpn 'sudo tailscale set --exit-node=trindatimes'
abbr -a exitfakevpn 'sudo tailscale up --exit-node='
abbr -a update-arch-mirrors 'rate-mirrors --disable-comments-in-file --entry-country=BR --protocol=https arch --max-delay 7200 | sudo tee /etc/pacman.d/mirrorlist'
abbr -a update-eos-mirrors 'rate-mirrors --disable-comments-in-file --entry-country=BR --protocol=https endeavouros  | sudo tee /etc/pacman.d/endeavouros-mirrorlist'

# programs 
abbr -a ipy ipython
abbr -a lg lazygit
abbr -a cp 'cp -r'
abbr -a ggen 'gedent gen (gedent template list | fzf) '
abbr -a periodic-table 'npx periodic-table-cli'
abbr -a yadmgui 'yadm enter gitui'

# ledger abbr -a
abbr -a hled hledger

# lsd
abbr -a l ls
abbr -a ls 'eza --icons=always'
abbr -a ll 'eza -l --icons=always'
abbr -a la 'eza -a --icons=always'
abbr -a lla 'eza -la --icons=always'
abbr -a lt 'eza --tree --icons=always'

abbr -a cat bat
abbr -a cd z

#cargo
abbr -a cargoclippy 'cargo clippy --fix --allow-dirty --allow-staged -- -W clippy::pedantic -W clippy::nursery'

# git 
abbr -a g git
abbr -a gf 'git diff --name-only'
abbr -a gac 'g a . && g c "updates" && g ps'

#scripts environment
abbr -a activatescripts '. ~/projects/scripts/.venv/bin/activate.fish'

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
