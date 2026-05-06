let mise_auto_install_hook = {||
    if (^mise settings ls --json | from json | get auto_install --optional | default false) {
        if (^mise ls --missing --json | from json | transpose name data | flatten data --all | where not installed | is-not-empty) {
          ^mise install;
          return;
        }
    }
}

$env.config.hooks.env_change = $env.config.hooks.env_change | insert __MISE_DIFF [$mise_auto_install_hook]
