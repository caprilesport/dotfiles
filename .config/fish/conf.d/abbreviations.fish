#shortcuts
abbr -a :q exit
abbr -a :! exit
abbr -a tf 'tail -f'
abbr -a - "z -"
abbr -a ... "cd ../../"
abbr -a .... "cd ../../../"
abbr -a ..... "cd ../../../../"
abbr -a --set-cursor awkp "awk '{print \$%}'"
abbr -a fgj "fg (jobs | fzf | awk '{print \$2}')"

abbr -a rp 'recli pull | next-job'
abbr -a ri 'recli info'
abbr -a rf 'recli fetch'
abbr -a rs 'recli status'
abbr -a rq 'recli queue'

abbr -a --set-cursor remote-dir "recli info % | rg 'remote_dir' | awk '{print \$2}' | wl-copy"
abbr -a --set-cursor local-dir "cd (recli info % | rg 'work_dir' | awk '{print \$2}')"

# clusters
abbr -a qsj 'ssh jupiter "qstat"'
abbr -a qsb 'ssh -t babel "pueue"'
abbr -a qsn 'ssh newton "squeue"'
abbr -a pq pueue
abbr -a geemloboc 'ssh loboc "qstat" | rg "vport|mrauen|krauskopf|famorim|viniglitz"'

# system
abbr -a mkdir 'mkdir -p'
abbr -a reload 'exec fish'
abbr -a update-arch-mirrors 'rate-mirrors --disable-comments-in-file --entry-country=BR --protocol=https arch --max-delay 7200 | sudo tee /etc/pacman.d/mirrorlist'
abbr -a update-eos-mirrors 'rate-mirrors --disable-comments-in-file --entry-country=BR --protocol=https endeavouros  | sudo tee /etc/pacman.d/endeavouros-mirrorlist'
abbr -a fuckchemcraft 'xdotool search --class "chemcraft" windowactivate'

abbr -a remove-ext "(path change-extension '' )"

# programs 
abbr -a ipy ipython
abbr -a lg lazygit
abbr -a cp 'cp -r'
abbr -a du dust
abbr -a scp 'scp -r'
abbr -a ggen 'gedent gen (gedent template list | fzf) '
abbr -a periodic-table 'npx periodic-table-cli'
abbr -a yadmgui 'yadm enter gitui'
abbr -a --set-cursor rnr 'rnr regex --no-dump % * -f'
abbr -a rg "rg -j1"

# lsd
abbr -a l ls
abbr -a --set-cursor ls 'eza --icons auto'
abbr -a --set-cursor ll 'eza -l --icons auto'
abbr -a --set-cursor la 'eza -a --icons auto'
abbr -a --set-cursor lla 'eza -la --icons auto'
abbr -a --set-cursor lt 'eza --tree --icons auto'

abbr -a cat bat

#cargo
abbr -a cclippy 'cargo clippy --fix --allow-dirty --allow-staged -- -W clippy::pedantic -W clippy::nursery'

# git 
abbr -a g git
abbr -a gf 'git diff --name-only'
abbr -a gac 'git a . && git c "updates" && git ps'
abbr -a gs 'git status'
abbr -a fuzzygitlog 'git log | fzf | awk \'{print $7}\''

# orca stuff
abbr -a energy 'grep -i "final gibbs free energy" *.out'
abbr -a imfreq 'grep -i "imaginary mode" *.out'
abbr -a geomcycle 'grep -i "geometry optimization cycle" *.out'
abbr -a scanprogress 'grep -i "RELAXED SURFACE SCAN STEP" *.out'

# other
abbr -a rmfilter 'rm (ls | rg -v (string trim -c "|" (for i in (ls | fzf -m); echo -n "$i|"; end)))'
