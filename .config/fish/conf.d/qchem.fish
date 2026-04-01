function xtbopt -a file_name charge --description "optimize the xyz file in xtb"
    mkdir .xtbopt
    cp "$file_name" .xtbopt
    cd .xtbopt
    xtb "$file_name" --opt -T 12
    cp xtbopt.xyz ..
    cd ..
    molv xtbopt.xyz
end

function xtbhess -a file_name charge
    set hessname (split string "." file_name)
    cp $file_name .xtbhess/
    mkdir -p .xtbhess
    cd .xtbhess
    if [ -z "$charge" ]
        gedent gen hessian "$file_name" --procs 8
    else
        gedent gen hessian "$file_name" --charge "$charge" --procs 8
    end

    job "$base_name".inp
    cp "$base_name".hess ..
    cd ..
end

function geninit -a file
    if [ -z "$argv" ]
        set file init.xyz
    end
    wl-paste -t text | sed -r '/^\s*$/d' >"$file"
end

function setup-calc
    argparse r/reverse 'c/charge=' i/irc -- $argv
    or return 1

    if set -q argv[1]
        set basefile (string split "." "$argv[1]" -f1)
    else
        set basefile init
    end

    set -q _flag_charge
    or set -l _flag_charge 0

    if [ -z "$filename" ]
        set basefile init
    else
        set basefile (string split "." "$filename" -f1)
    end

    if [ -z "$_flag_reverse" ]
        set product "$basefile"_IRC_F.xyz
        set reagent "$basefile"_IRC_B.xyz
    else
        set reagent "$basefile"_IRC_B.xyz
        set product "$basefile"_IRC_F.xyz
    end

    if [ -z $_flag_irc ]
        mkdir ../react-freq -p
        mkdir ../prod-freq -p
        cp "$reagent" ../react-freq/init.xyz
        cp "$product" ../prod-freq/init.xyz
        gedent gen optfreq ../react-freq/init.xyz --charge $_flag_charge
        gedent gen optfreq ../prod-freq/init.xyz --charge $_flag_charge
        cd ..
    else
        mkdir ../irc
        cp "$basefile".xyz ../irc
        cp "$basefile".hess ../irc
        cd ../irc
        gedent gen irc init.xyz --charge $_flag_charge
    end

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

function lab
    source ~/.chem-lab/bin/activate.fish
end
