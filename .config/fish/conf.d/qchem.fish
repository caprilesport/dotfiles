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

function sngo -a remote
    argparse s/sync -- $argv
    or return 0

    if [ -z $_flag_sync ]
        csync "$remote" push && sshcd "$remote"
    else
        csync "$remote" push sync && sshcd "$remote"
    end

end
