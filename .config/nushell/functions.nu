def --env --wrapped nj [...args: string] {
    if ($args | is-empty) {
        let dir = (^next-job next | str replace --regex '\n+$' '')

        if ($dir != "") and ($dir | path type) == "dir" {
            dirs add $dir
        } else {
            print "No jobs in queue"
        }
    } else {
        ^next-job ...$args
    }
}

def --wrapped molv [...files: string] {
    let exe = "/home/vport/.wine/drive_c/Chemcraft/Chemcraft.exe"

    if ($files | is-empty) {
        ^wine $exe
    } else {
        for file in $files {
            job spawn {
                ^wine $exe $file out+err> /dev/null
            } | ignore
        }
    }
}
