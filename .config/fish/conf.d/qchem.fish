function geninit -a file
    if [ -z "$argv" ]
        set file init.xyz
    end
    wl-paste -t text | sed -r '/^\s*$/d' >"$file"
end

# TODO: func to use puxa-job in a pattern in a recli job ID
# TODO: func to cd to the remote directory of a recli job ID

# TODO: add optional parameter to pull a specific extension, defauts to .out
function pull_out
    argparse v/verbose -- $argv
    or return

    if test (count $argv) -lt 1
        echo "Error: missing ID"
        return 1
    end
    set ID $argv[1]

    if set -q _flag_verbose
        set fish_trace 1
    end

    set remotedir (recli info $ID | rg remote_dir | awk '{print $2}')
    set remote (recli info $ID | rg remote | head -n1 | awk '{print $2}')
    set file (recli info $ID | rg filename | awk '{print $2}')

    if set -q _flag_verbose
        scp -v -O $remote:$remotedir/$file.out .
    else
        scp -O $remote:$remotedir/$file.out .
    end
end

function go_remote -a ID
    set remotedir (recli info $ID | rg remote_dir | awk '{print $2}')
    set remote (recli info $ID | rg remote | head -n1 | awk '{print $2}')
    echo $remote $remotedir
end

function mdenv
    source (/home/vport/miniconda3/bin/conda shell.fish hook | psub)
    conda activate ambertools
    source ~/projects/scripts/GMXRC.fish
end
