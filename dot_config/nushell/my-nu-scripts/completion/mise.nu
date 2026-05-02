# Dev tools, env vars, and tasks in one CLI
export extern main []

# Initializes mise in the current shell session
export extern "activate" [
  shell_type: string   # Shell type to generate the script for
  --quiet (-q)         # Suppress non-error messages
  --shims              # Use shims instead of modifying PATH
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j): int     # How many jobs to run in parallel [default: 8]
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Manage tool version aliases.
export extern "tool-alias" []

# Manage backends
export extern "backends" []

# List all the active runtime bin paths
export extern "bin-paths" []

# Manage the mise cache
export extern "cache" []

# Generate shell completions
export extern "completion" [
  shell: string        # Shell type to generate completions for
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Manage config files [aliases: cfg]
export extern "config" []

# Disable mise for current shell session
export extern "deactivate" []

# Check mise installation for possible problems [aliases: dr]
export extern "doctor" []

# Starts a new shell with the mise environment built from the current configuration
export extern "en" [
  dir                  # Directory to start the shell in
  --shell (-s): string # Shell to start
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Exports env vars to activate mise a single time [aliases: e]
export extern "env" [
  ...tools: list<string> # Tool(s) to use
  --dotenv (-D)          # Output in dotenv format
  --json (-J)            # Output in JSON format
  --shell (-s): string   # Shell type to generate environment variables for
  --redacted             # Only show redacted environment variables
  --values               # Only show values of environment variables
  --cd (-C): directory   # Change directory before running command
  --env (-E): string     # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int        # How many jobs to run in parallel [default: 8]
  --quiet (-q)           # Suppress non-error messages
  --yes (-y)             # Answer yes to all confirmation prompts
  --raw                  # Read/write directly to stdin/stdout/stderr instead of by line
  --locked               # Require lockfile URLs to be present during installation
  --silent               # Suppress all task output and mise non-error messages
  --help (-h)            # Print help (see a summary with '-h')
]

# Execute a command with tool(s) set [aliases: x]
export extern "exec" [
  ...tools: list<string> # Tool(s) to start e.g.: node@20 python@3.10
  --command (-c): string # Command string to execute
  --jobs (-j):int        # Number of jobs to run in parallel
  --raw                  # Directly pipe stdin/stdout/stderr from plugin to user Sets --jobs=1
  --cd (-C): directory   # Change directory before running command
  --env (-E): string     # Set the environment for loading `mise.<ENV>.toml`
  --quiet (-q)           # Suppress non-error messages
  --yes (-y)             # Answer yes to all confirmation prompts
  --locked               # Require lockfile URLs to be present during installation
  --silent               # Suppress all task output and mise non-error messages
  --help (-h)            # Print help (see a summary with '-h')
]

# Formats mise.toml
export extern "fmt" []

# Generate files for various tools/services [aliases: gen]
export extern "generate" []

# Removes mise CLI and all related data
export extern "implode" []

# Edit mise.toml interactively
export extern "edit" [
  path                 # Path to the config file to create
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Install a tool version [aliases: i]
export extern "install" [
  ...tools: string     # Tool(s) to install e.g.: node@20
  --force (-f)         # Force reinstall even if already installed
  --jobs (-j):int      # Number of jobs to run in parallel
  --before: string     # Only install versions released before this date
  --raw                # Directly pipe stdin/stdout/stderr from plugin to user Sets --jobs=1
  --shared: string     # [experimental] Install tool(s) to a shared directory
  --system             # [experimental] Install tool(s) to the system-wide shared directory
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Install a tool version to a specific path
export extern "install-into" [
  tool: string         # Tool to install e.g.: node@20
  path: path           # Path to install the tool into
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Gets the latest available version for a plugin
export extern "latest" [
  tool: string         # Tool to get the latest version of
  --installed (-i)     # Show latest installed instead of available version
  --before: string     # Only consider versions released before this date
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Symlinks a tool version into mise [aliases: ln]
export extern "link" [
  tool: string         # Tool name and version to create a symlink for
  path: path           # The local path to the tool version
  --force (-f)         # Overwrite an existing tool version if it exists
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Update lockfile checksums and URLs for all specified platforms
export extern "lock" [
  ...tool: list<string>    # Tool(s) to update in lockfile
  --global (-g)            # Include global config lockfile (~/.config/mise/mise.lock)
  --jobs (-j):int          # Number of jobs to run in parallel
  --platform (-p):  string # Comma-separated list of platforms to target
  --local                  # Update mise.local.lock instead of mise.lock
  --cd (-C): directory     # Change directory before running command
  --env (-E): string       # Set the environment for loading `mise.<ENV>.toml`
  --quiet (-q)             # Suppress non-error messages
  --yes (-y)               # Answer yes to all confirmation prompts
  --raw                    # Read/write directly to stdin/stdout/stderr instead of by line
  --locked                 # Require lockfile URLs to be present during installation
  --silent                 # Suppress all task output and mise non-error messages
  --help (-h)              # Print help (see a summary with '-h')
]

# List installed and active tool versions [aliases: list]
export extern "ls" [
  ...installed_tool: list<string> # Only show tool versions from tool
  --current (-c)                  # Only show tool versions currently specified in a mise.toml
  --global (-g)                   # Only show tool versions currently specified in the global mise.toml
  --installed (-i)                # Only show tool versions that are installed (Hides tools defined in mise.toml but not installed)
  --json (-J)                     # Output in JSON format
  --local (-l)                    # Only show tool versions currently specified in the local mise.toml
  --missing (-m)                  # Display missing tool versions
  --outdated                      # Display whether a version is outdated
  --prefix: string                # Display versions matching this prefix
  --prunable                      # List only tools that can be pruned with `mise prune`
  --cd (-C): directory            # Change directory before running command
  --env (-E): string              # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int                 # How many jobs to run in parallel [default: 8]
  --quiet (-q)                    # Suppress non-error messages
  --yes (-y)                      # Answer yes to all confirmation prompts
  --raw                           # Read/write directly to stdin/stdout/stderr instead of by line
  --locked                        # Require lockfile URLs to be present during installation
  --silent                        # Suppress all task output and mise non-error messages
  --help (-h)                     # Print help (see a summary with '-h')
]

# List runtime versions available for install.
export extern "ls-remote" [
  tool: string         # Tool to get versions for
  prefix: string       # The version prefix to use when querying the latest version
  --all                # Show all installed plugins and versions
  --json (-J)          # Output in JSON format (includes version metadata like created_at timestamps when available)
  --prerelease         # Include pre-release versions in the output for backends that report
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# [experimental] Run Model Context Protocol (MCP) server
export extern "mcp" []

# [experimental] Build OCI container images from a mise.toml
export extern "oci" []

# Shows outdated tool versions
export extern "outdated" [
  ...tools: list<string> # Tool(s) to show outdated versions for
  --json (-J)            # Output in JSON format
  --bump (-l)            # Compares against the latest versions available, not what matches the current config
  --local                # Only show outdated tools defined in local config files
  --cd (-C): directory   # Change directory before running command
  --env (-E): string     # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int        # How many jobs to run in parallel [default: 8]
  --quiet (-q)           # Suppress non-error messages
  --yes (-y)             # Answer yes to all confirmation prompts
  --raw                  # Read/write directly to stdin/stdout/stderr instead of by line
  --locked               # Require lockfile URLs to be present during installation
  --silent               # Suppress all task output and mise non-error messages
  --help (-h)            # Print help (see a summary with '-h')
]

# Manage plugins [aliases: p]
export extern "plugins" []

# [experimental] Manage project dependencies [aliases: dep]
export extern "deps" [
  provider             # Provider to operate on (runs only this provider, or use with --explain)
  --explain            # Show why a provider is fresh or stale (requires a provider argument)
  --force (-f)         # Force run all deps steps even if outputs are fresh
  --list               # Show what deps providers are available
  --only: string       # Run specific deps rule(s) only
  --skip: string       # Skip specific deps rule(s)
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Delete unused versions of tools
export extern "prune" [
  ...installed_tool: list<string> # Prune only these tools
  --configs                       # Prune only tracked and trusted configuration links that point to non-existent configurations
  --tools                         # Prune only unused versions of tools
  --cd (-C): directory            # Change directory before running command
  --env (-E): string              # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int                 # How many jobs to run in parallel [default: 8]
  --quiet (-q)                    # Suppress non-error messages
  --yes (-y)                      # Answer yes to all confirmation prompts
  --raw                           # Read/write directly to stdin/stdout/stderr instead of by line
  --locked                        # Require lockfile URLs to be present during installation
  --silent                        # Suppress all task output and mise non-error messages
  --help (-h)                     # Print help (see a summary with '-h')
]

# List available tools to install
export extern "registry" [
  name                   # Show only the specified tool's full name
  --backend (-b): string # Show only tools for this backend
  --json (-J)            # Output in JSON format
  --security             # Include security features for each tool's backends in JSON output.
  --cd (-C): directory   # Change directory before running command
  --env (-E): string     # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int        # How many jobs to run in parallel [default: 8]
  --quiet (-q)           # Suppress non-error messages
  --yes (-y)             # Answer yes to all confirmation prompts
  --raw                  # Read/write directly to stdin/stdout/stderr instead of by line
  --locked               # Require lockfile URLs to be present during installation
  --silent               # Suppress all task output and mise non-error messages
  --help (-h)            # Print help (see a summary with '-h')
]

# Creates new shims based on bin paths from currently installed tools.
export extern "reshim" []

# Run task(s) [aliases: r]
export extern "run" [
  task                     # Tasks to run
  ...args: list<string>    # Arguments to pass to the tasks. Use ":::" to separate tasks
  --cd (-C): path          # Change to this directory before executing the command
  --force (-f)             # Force the tasks to run even if outputs are up to date
  --jobs (-j):int          # Number of tasks to run in parallel
  --output (-o): string    # Change how tasks information is output when running tasks
  --quiet (-q)             # Don't show extra output
  --raw (-r)               # Read/write directly to stdin/stdout/stderr instead of by line
  --shell (-s): string     # Shell to use to run toml tasks
  --silent (-S)            # Don't show any output except for errors
  --tool (-t) tool: string # Tool(s) to run in addition to what is in mise.toml files e.g.: node@20 python@3.10
  --timeout : string       # Timeout for the task to complete
]

# Search for tools in the registry
export extern "search" [
  name                 # The tool to search for
  --interactive (-i)   # Show interactive search
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Updates mise itself.
export extern "self-update" []

# Set environment variables in mise.toml
export extern "set" [
  ...env_var           # Environment variable(s) to set
  --env (-E): string   # Create/modify an environment-specific config file like .mise.<env>.toml
  --global (-g)        # Set the environment variable in the global config file
  --file: path         # The TOML file to update
  --prompt             # Prompt for environment variable values
  --stdin              # Read the value from stdin (for multiline input)
  --cd (-C): directory # Change directory before running command
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Manage settings
export extern "settings" [
  setting              # Name of setting
  value                # Setting value to set
  --all (-a)           # List all settings
  --json (-J)          # Output in JSON format
  --local (-l)         # Use the local config file instead of the global one
  --toml (-T)          # Output in TOML format
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Sets a tool version for the current session. [aliases: sh]
export extern "shell" [
  ...tool: string      # Tool(s) to use
  --jobs (-j):int      # Number of jobs to run in parallel
  --unset (-u)         # Removes a previously set version
  --raw                # Directly pipe stdin/stdout/stderr from plugin to user Sets --jobs=1
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Manage shell aliases.
export extern "shell-alias" []

# Synchronize tools from other version managers with mise
export extern "sync" []

# Manage tasks [aliases: t]
export extern "tasks" [
  task                 # Task name to get info of
  --global (-g)        # Only show global tasks
  --json (-J)          # Output in JSON format
  --local (-l)         # Only show non-global tasks
  --extended (-x)      # Show all columns
  --all                # Load all tasks from the entire monorepo, including sibling directories.
  --hidden             # Show hidden tasks
  --sort: string       # Sort by column. Default is name.
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Test a tool installs and executes
export extern "test-tool" [
  ...tools             # Tool(s) to test
  --all (-a)           # Test every tool specified in registry/
  --jobs (-j):int      # Number of jobs to run in parallel
  --raw                # Directly pipe stdin/stdout/stderr from plugin to user Sets --jobs=1
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Display git provider tokens mise will use
export extern "token" []

# Gets information about a tool
export extern "tool" [
  tool: string         # Tool name to get information about
  --json (-J)          # Output in JSON format
  --active             # Only show active versions
  --backend            # Only show backend field
  --description        # Only show description field
  --installed          # Only show installed versions
  --requested          # Only show requested versions
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Execute a tool stub
export extern "tool-stub" []

# Marks a config file as trusted
export extern "trust" [
  config_file: path    # The config file to trust
  --all (-a)           # Trust all config files in the current directory and its parents
  --ignore             # Do not trust this config and ignore it in the future
  --show               # Show the trusted status of config files from the current directory and its parents.
  --untrust            # No longer trust this config, will prompt in the future
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Removes installed tool versions
export extern "uninstall" [
  ...tools: list<string> # Tool(s) to remove
  --all (-a)             # Delete all installed versions
  --cd (-C): directory   # Change directory before running command
  --env (-E): string     # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int        # How many jobs to run in parallel [default: 8]
  --quiet (-q)           # Suppress non-error messages
  --yes (-y)             # Answer yes to all confirmation prompts
  --raw                  # Read/write directly to stdin/stdout/stderr instead of by line
  --locked               # Require lockfile URLs to be present during installation
  --silent               # Suppress all task output and mise non-error messages
  --help (-h)            # Print help (see a summary with '-h')
]

# Remove environment variable(s) from the config file.
export extern "unset" [
  ...env_key           # Environment variable(s) to remove
  --file (-f): path    # Specify a file to use instead of `mise.toml`
  --global (-g)        # Use the global config file
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# No longer trust a config, will prompt in the future
export extern "untrust" []

# Removes installed tool versions from mise.toml [aliases: rm, remove]
export extern "unuse" [
  ...installed_tool: list<string> # Tool(s) to remove
  --env (-e): string              # Create/modify an environment-specific config file like .mise.<env>.toml
  --global (-g)                   # Use the global config file (`~/.config/mise/config.toml`) instead of the local one
  --path (-p) path: path          # Specify a path to a config file or directory
  --cd (-C): directory            # Change directory before running command
  --jobs (-j):int                 # How many jobs to run in parallel [default: 8]
  --quiet (-q)                    # Suppress non-error messages
  --yes (-y)                      # Answer yes to all confirmation prompts
  --raw                           # Read/write directly to stdin/stdout/stderr instead of by line
  --locked                        # Require lockfile URLs to be present during installation
  --silent                        # Suppress all task output and mise non-error messages
  --help (-h)                     # Print help (see a summary with '-h')
]

# Upgrades outdated tools [aliases: up]
export extern "upgrade" [
  ...installed_tool: list<string> # Tool(s) to upgrade
  --interactive (-i)              # Display multiselect menu to choose which tools to upgrade
  --jobs (-j):int                 # Number of jobs to run in parallel
  --bump (-l)                     # Upgrades to the latest version available, bumping the version in mise.toml
  --exclude (-x): list<string>    # Tool(s) to exclude from upgrading
  --before: string                # Only upgrade to versions released before this date
  --local                         # Only upgrade tools defined in local config files
  --raw                           # Directly pipe stdin/stdout/stderr from plugin to user Sets --jobs=1
  --cd (-C): directory            # Change directory before running command
  --env (-E): string              # Set the environment for loading `mise.<ENV>.toml`
  --quiet (-q)                    # Suppress non-error messages
  --yes (-y)                      # Answer yes to all confirmation prompts
  --locked                        # Require lockfile URLs to be present during installation
  --silent                        # Suppress all task output and mise non-error messages
  --help (-h)                     # Print help (see a summary with '-h')
]

# Installs a tool and adds the version to mise.toml. [aliases: u]
export extern "use" [
  ...tools: list<string> # Tool(s) to add to config file
  --env (-e): string     # Create/modify an environment-specific config file like .mise.<env>.toml
  --force (-f)           # Force reinstall even if already installed
  --global (-g)          # Use the global config file (`~/.config/mise/config.toml`) instead of the local one
  --jobs (-j):int        # Number of jobs to run in parallel
  --path (-p) path: path # Specify a path to a config file or directory
  --before: string       # Only install versions released before this date
  --fuzzy                # Save fuzzy version to config file
  --pin                  # Save exact version to config file
  --raw                  # Directly pipe stdin/stdout/stderr from plugin to user Sets `--jobs=1`
  --remove: string       # Remove the plugin(s) from config file
  --cd (-C): directory   # Change directory before running command
  --quiet (-q)           # Suppress non-error messages
  --yes (-y)             # Answer yes to all confirmation prompts
  --locked               # Require lockfile URLs to be present during installation
  --silent               # Suppress all task output and mise non-error messages
  --help (-h)            # Print help (see a summary with '-h')
]

# Display the version of mise [aliases: v]
export extern "version" []

# Run task(s) and watch for changes to rerun it [aliases: w]
export extern "watch" [
  task                       # Tasks to run
  ...args                    # Task and arguments to run
  --restart (-r)             # Restart the process if it's still running
  --signal (-s): string      # Send a signal to the process when it's still running
  --debounce (-d): int       # Time to wait for new events before taking action
  --postpone (-p)            # Wait until first change before running command
  --poll: list<string>       # Poll for filesystem changes
  --workdir: directory       # Set the working directory
  --cd (-C): directory       # Change directory before running command
  --jobs (-j):int            # How many jobs to run in parallel [default: 8]
  --yes (-y)                 # Answer yes to all confirmation prompts
  --raw                      # Read/write directly to stdin/stdout/stderr instead of by line
  --locked                   # Require lockfile URLs to be present during installation
  --silent                   # Suppress all task output and mise non-error messages
  --help (-h)                # Print help (see a summary with '-h')
  --watch (-w) path: path    # Watch a specific file or directory
  --exts (-e): string        # Filename extensions to filter to
  --filter (-f): string      # Filename patterns to filter to
  --ignore (-i): string      # Filename patterns to filter out
  --clear (-c): list<string> # Clear screen before running command
  --notify (-N)              # Alert when commands start and end
  --color: string            # When to use terminal colours
  --timings                  # Print how long the command took to run
  --quiet (-q)               # Don't print starting and stopping messages
  --bell                     # Ring the terminal bell on command completion
  --shell : string           # Use a different shell
  --env (-E): string         # Add env vars to the command
  --manual                   # Show the manual page
]

# Display the installation path for a tool
export extern "where" [
  tool: string         # Tool(s) to look up
  --cd (-C): directory # Change directory before running command
  --env (-E): string   # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int      # How many jobs to run in parallel [default: 8]
  --quiet (-q)         # Suppress non-error messages
  --yes (-y)           # Answer yes to all confirmation prompts
  --raw                # Read/write directly to stdin/stdout/stderr instead of by line
  --locked             # Require lockfile URLs to be present during installation
  --silent             # Suppress all task output and mise non-error messages
  --help (-h)          # Print help (see a summary with '-h')
]

# Shows the path that a tool's bin points to.
export extern "which" [
  bin_name                 # The bin to look up
  --tool (-t) tool: string # Use a specific tool@version
  --plugin                 # Show the plugin name instead of the path
  --version                # Show the version instead of the path
  --cd (-C): directory     # Change directory before running command
  --env (-E): string       # Set the environment for loading `mise.<ENV>.toml`
  --jobs (-j):int          # How many jobs to run in parallel [default: 8]
  --quiet (-q)             # Suppress non-error messages
  --yes (-y)               # Answer yes to all confirmation prompts
  --raw                    # Read/write directly to stdin/stdout/stderr instead of by line
  --locked                 # Require lockfile URLs to be present during installation
  --silent                 # Suppress all task output and mise non-error messages
  --help (-h)              # Print help (see a summary with '-h')
]

# Print this message or the help of the given subcommand(s)
export extern "help" []
