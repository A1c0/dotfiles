# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.show_banner = false
$env.config.completions.algorithm = "substring"

# Note: The conversions happen *after* config.nu is loaded
let bool_conversion = {
    from_string: { |s| $s | into bool }
    to_string: { |v| $v | into string }
}
$env.ENV_CONVERSIONS = $env.ENV_CONVERSIONS | insert __zoxide_hooked $bool_conversion

^mise activate | ignore; # To active mise in subshell

use ~/.cache/mise/activate.nu;
source ~/.cache/zoxide/.zoxide.nu;
source ~/.cache/atuin/init.nu;

use ./nu_scripts/custom-completions/zellij/zellij-completions.nu *

# Theme
source ./nu_scripts/themes/nu-themes/catppuccin-mocha.nu
source ~/.cache/vivid/init.nu
$env.BAT_THEME = "Catppuccin Mocha"
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.FZF_DEFAULT_OPTS = " --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 --color=selected-bg:#494d64 --multi";
# Nu Shells feature
use std/dirs shells-aliases *

# Prompt
use ~/.cache/starship/init.nu


# --------- My Nu Script ---------
# Utils
source ./my-nu-scripts/utils/custom-from.nu
source ./my-nu-scripts/utils/tranform.nu
source ./my-nu-scripts/utils/common.nu
# Alias
source ./my-nu-scripts/alias/git.nu
source ./my-nu-scripts/alias/docker.nu
source ./my-nu-scripts/alias/common.nu
# Module
use ./my-nu-scripts/module/aws-profile.nu
use ./my-nu-scripts/module/reminder.nu
use ./my-nu-scripts/module/alacritty-config.nu
use ./my-nu-scripts/module/mac.nu
# Completion
use ./my-nu-scripts/completion/mise.nu
# Config
source ./my-nu-scripts/config/external-completer.nu
source ./my-nu-scripts/config/mise_auto_install.nu

# PWD hook for tlk
$env.config.hooks.env_change.PWD = $env.config.hooks.env_change | get PWD --optional | default [] | append {
  condition: {|_, after| $after | path join 'toolkit' | path exists }
  code: "overlay use --prefix toolkit as tlk"
}
