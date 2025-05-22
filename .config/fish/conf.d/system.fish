function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function hx
    if [ -z "$argv" ]
        command hx .
    else
        command hx $argv
    end
end

function goto-line -a text_pattern file
    hx $file:(sed -n "/$text_pattern/{=;q;}" $file)
end

function take -a name
    mkdir -p $name
    cd $name
end

function cleantex
    rm *.log
    rm *.pdfsync
    rm *.aux
    rm *.bcf*
    rm *fdb*
    rm *fls
    rm *.out
    rm *sync*
    rm report.toc
end

# ditch the outputs of chemcraft
function molv
    if [ -z "$argv" ]
        wine /home/vport/.wine/drive_c/Chemcraft/Chemcraft.exe
    else
        for file in $argv
            wine /home/vport/.wine/drive_c/Chemcraft/Chemcraft.exe "$file" &>/dev/null &
        end
    end
end
