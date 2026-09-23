$env.config.abbreviations = {
    lg: lazygit
    #system
    reload: "exec nu"
    ll: "ls -l"
    ":q": exit
    ":!": exit
    tf: "tail -f"
    mopen:xdg-open
    # -: "z -"

    #recli
    rp:"recli pull | next-job"
    ri:"recli info"
    rf:"recli fetch"
    rs:"recli status"
    rq:"recli queue"

    #git
    g: git
    gd: "git diff --name-only"
    gac: 'git a . && git c "updates" && git ps'
    gs: "git status"

    #clusters
    qsj: 'ssh jupiter "qstat"'
    # "qsb": "ssh -t babel "pueue""
    # "qsn": "ssh newton "squeue""
    pq: pueue

    #cargo
    cclippy: "cargo clippy --fix --allow-dirty --allow-staged -- -W clippy::pedantic -W clippy::nursery"


}
