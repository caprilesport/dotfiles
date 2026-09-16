module completions {

  def "nu-complete gedent template-names" [] {
    ^gedent _complete templates | lines
  }

  def "nu-complete gedent generator" [] {
    [ "bash" "elvish" "fish" "nushell" "powershell" "zsh" ]
  }

  # A command-line interface to generate computational chemistry inputs
  export extern gedent [
    --health                  # Check if gedent is set up correctly
    --generate: string@"nu-complete gedent generator" # If provided, outputs the completion file for given shell
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # Generate a new input based on a template
  export extern "gedent gen" [
    --print(-p)               # Print to screen and don't save file
    --ext: string             # Override output file extension
    --software: string        # Override software (used for template disambiguation)
    --method: string          # Set method
    --basis-set: string       # Set `basis_set`
    --dispersion: string      # Set dispersion
    --solvent(-s): string     # Set solvent to value and solvation to true
    --solvation-model: string # Set `solvation_model`
    --charge(-c): string      # Set charge
    --mult(-m): string        # Set mult
    --nprocs: string          # Set nprocs
    --mem: string             # Set mem
    --var: string             # Set an arbitrary template variable (KEY=VALUE, value parsed as TOML)
    --dry-run                 # Validate and show what would be generated without writing any files
    --show-context            # Print the full Tera context as JSON (useful for template debugging)
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
    template_name: string@"nu-complete gedent template-names"     # The template to look for in ~/.config/gedent/templates
    ...xyz_files: path        # xyz files
  ]

  # Access gedent configuration
  export extern "gedent config" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # Prints the location and the currently used configuration
  export extern "gedent config print" [
    --location(-l)            # Print the path of the printed config
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # Opens a config file in $EDITOR
  export extern "gedent config edit" [
    --global(-g)              # Edit the global ~/.config/gedent/gedent.toml instead of the nearest local one
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "gedent config help" [
  ]

  # Prints the location and the currently used configuration
  export extern "gedent config help print" [
  ]

  # Opens a config file in $EDITOR
  export extern "gedent config help edit" [
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "gedent config help help" [
  ]

  # Access template functionality
  export extern "gedent template" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # Prints the unformatted template to stdout
  export extern "gedent template print" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
    template: string@"nu-complete gedent template-names"
  ]

  # Create a new template from a preset located in ~/.config/gedent/presets
  export extern "gedent template new" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
    template_name: string
    software: string
  ]

  # List available templates
  export extern "gedent template list" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # Edit a given template
  export extern "gedent template edit" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
    template: string@"nu-complete gedent template-names"
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "gedent template help" [
  ]

  # Prints the unformatted template to stdout
  export extern "gedent template help print" [
  ]

  # Create a new template from a preset located in ~/.config/gedent/presets
  export extern "gedent template help new" [
  ]

  # List available templates
  export extern "gedent template help list" [
  ]

  # Edit a given template
  export extern "gedent template help edit" [
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "gedent template help help" [
  ]

  # Shell completion endpoint — hidden from normal help output. `gedent _complete templates` prints one completable name per line
  export extern "gedent _complete" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # List completable template names (one per line)
  export extern "gedent _complete templates" [
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "gedent _complete help" [
  ]

  # List completable template names (one per line)
  export extern "gedent _complete help templates" [
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "gedent _complete help help" [
  ]

  # Initiate a gedent project in the current directory
  export extern "gedent init" [
    --software: string        # Set software (used for template disambiguation)
    --method: string          # Set method
    --basis-set: string       # Set `basis_set`
    --dispersion: string      # Set dispersion
    --solvent(-s): string     # Set solvent
    --solvation-model: string # Set `solvation_model`
    --charge(-c): string      # Set charge
    --mult(-m): string        # Set mult
    --nprocs: string          # Set nprocs
    --mem: string             # Set mem
    --verbose(-v)             # Increase logging verbosity
    --quiet(-q)               # Decrease logging verbosity
    --help(-h)                # Print help
    --version(-V)             # Print version
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "gedent help" [
  ]

  # Generate a new input based on a template
  export extern "gedent help gen" [
  ]

  # Access gedent configuration
  export extern "gedent help config" [
  ]

  # Prints the location and the currently used configuration
  export extern "gedent help config print" [
  ]

  # Opens a config file in $EDITOR
  export extern "gedent help config edit" [
  ]

  # Access template functionality
  export extern "gedent help template" [
  ]

  # Prints the unformatted template to stdout
  export extern "gedent help template print" [
  ]

  # Create a new template from a preset located in ~/.config/gedent/presets
  export extern "gedent help template new" [
  ]

  # List available templates
  export extern "gedent help template list" [
  ]

  # Edit a given template
  export extern "gedent help template edit" [
  ]

  # Shell completion endpoint — hidden from normal help output. `gedent _complete templates` prints one completable name per line
  export extern "gedent help _complete" [
  ]

  # List completable template names (one per line)
  export extern "gedent help _complete templates" [
  ]

  # Initiate a gedent project in the current directory
  export extern "gedent help init" [
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "gedent help help" [
  ]

}

export use completions *
