# Utility helpers used by the Nushell config.

def partial-path-completions [prefix: string] {
    let parsed = ($prefix | path parse)
    let dir = (if $parsed.parent == "" { "." } else { $parsed.parent })
    let needle = ($prefix | path basename | str lowercase)

    try {
        ls -a $dir
        | where name != $dir
        | where { |entry|
            let base = ($entry.name | path basename | str lowercase)
            $needle == "" or ($base | str contains $needle)
        }
        | each { |entry|
            let value = if $entry.type == dir { $"($entry.name)/" } else { $entry.name }
            { value: $value, description: $entry.type }
        }
    } catch { [] }
}
