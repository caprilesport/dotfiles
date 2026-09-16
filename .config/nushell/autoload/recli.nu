module completions {

  # A remote job submission and management CLI.
  export extern recli [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
  ]

  # Fetches the latest status for all tracked jobs from the remotes
  export extern "recli fetch" [
    --remote(-r): string
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
  ]

  def "nu-complete recli submit strategy" [] {
    [ "script" "basename" "directory" ]
  }

  # Submits one or more jobs to a specified remote machine
  export extern "recli submit" [
    --remote(-r): string
    --files(-f): path         # Extra files to upload alongside every script, resolved relative to the current working directory
    --strategy: string@"nu-complete recli submit strategy" # Which files to upload from each script's directory (overrides `file_strategy` in config)
    --tags: string            # Tags to attach to the submitted job(s)
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
    ...jobfiles: path         # Job script(s) to submit (.pbs, .slurm, etc.)
  ]

  # Re-submits an existing job to a queue, optionally to a different remote
  export extern "recli resubmit" [
    --remote: string          # Submit to a different remote (re-uploads all files)
    --tags: string            # Replace the job's tags
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
    job_id: string            # Job UUID prefix to resubmit
  ]

  # Fetches the latest job statuses then downloads output files for finished jobs
  export extern "recli pull" [
    --all-files               # Download all files, ignoring the ignore file
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
    job_id?: string           # Job UUID prefix to pull a single job
  ]

  # Shows the live queue state on one or more remotes
  export extern "recli queue" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
    ...remotes: string        # Remotes to query (defaults to all with `check_queue` = true)
  ]

  def "nu-complete recli status status" [] {
    [ "queued" "running" "finished" "error" "undefined" ]
  }

  # Displays the status of jobs, with optional filters. By default it doesn't show jobs that are synced To show all jobs recorded, use the -a/--all flag
  export extern "recli status" [
    --all(-a)                 # Show all jobs
    --show-id                 # Show id for each job
    --id(-i): string          # Filter by UUID prefix
    --uuid(-u): string        # Filter by uuid
    --name(-n): string        # Filter by name
    --directory(-d): string   # Filter by directory
    --remote(-r): string      # Filter by remote
    --remote-id: string       # Filter by `remote_id`
    --status(-s): string@"nu-complete recli status status" # Filter by status
    --synced                  # Filter synced jobs
    --not-synced              # Filter non synced jobs
    --tag: string             # Filter by tag
    --queue: string           # Filter by queue
    --script: string          # Filter by script name (substring match)
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
  ]

  # Shows detailed information about a specific job
  export extern "recli info" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help
    --version(-V)             # Print version
    job: string               # Job UUID prefix (any unambiguous prefix length)
  ]

  # Shows the log output of a job from its remote directory
  export extern "recli log" [
    --pattern: string         # Show a specific file from the remote directory instead of the default log
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
    job_id: string            # Job UUID prefix
  ]

  # Cancels a running or queued job on its remote
  export extern "recli cancel" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
    job: string               # Job UUID prefix
  ]

  # Removes remote working directories for old, synced jobs
  export extern "recli prune" [
    --job: string             # Target a specific job by UUID prefix, bypassing the age filter
    --remote(-r): string      # Only consider jobs from this remote
    --days: string            # Minimum age in days since sync (overrides `prune_after_days` in config)
    --db                      # Also remove matching jobs from the local database
    --execute                 # Actually perform the deletion (default is dry run)
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
  ]

  def "nu-complete recli set status" [] {
    [ "queued" "running" "finished" "error" "undefined" ]
  }

  # Update fields on an existing job record
  export extern "recli set" [
    --work-dir: path          # Set the local working directory
    --remote-dir: path        # Set the remote working directory
    --remote: string          # Set the remote name
    --remote-id: string       # Set the remote job ID
    --script-file: string     # Set the script file path
    --status: string@"nu-complete recli set status" # Set the job status
    --tags: string            # Replace all tags
    --clear-tags              # Clear all tags
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help (see more with '--help')
    --version(-V)             # Print version
    job_id: string            # Job UUID prefix to update
  ]

  def "nu-complete recli completions shell" [] {
    [ "bash" "elvish" "fish" "nushell" "powershell" "zsh" ]
  }

  # Generate shell completion scripts
  export extern "recli completions" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --json                    # Output as JSON
    --help(-h)                # Print help
    --version(-V)             # Print version
    shell: string@"nu-complete recli completions shell" # The shell to generate the script for
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "recli help" [
  ]

  # Fetches the latest status for all tracked jobs from the remotes
  export extern "recli help fetch" [
  ]

  # Submits one or more jobs to a specified remote machine
  export extern "recli help submit" [
  ]

  # Re-submits an existing job to a queue, optionally to a different remote
  export extern "recli help resubmit" [
  ]

  # Fetches the latest job statuses then downloads output files for finished jobs
  export extern "recli help pull" [
  ]

  # Shows the live queue state on one or more remotes
  export extern "recli help queue" [
  ]

  # Displays the status of jobs, with optional filters. By default it doesn't show jobs that are synced To show all jobs recorded, use the -a/--all flag
  export extern "recli help status" [
  ]

  # Shows detailed information about a specific job
  export extern "recli help info" [
  ]

  # Shows the log output of a job from its remote directory
  export extern "recli help log" [
  ]

  # Cancels a running or queued job on its remote
  export extern "recli help cancel" [
  ]

  # Removes remote working directories for old, synced jobs
  export extern "recli help prune" [
  ]

  # Update fields on an existing job record
  export extern "recli help set" [
  ]

  # Generate shell completion scripts
  export extern "recli help completions" [
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "recli help help" [
  ]

}

export use completions *
