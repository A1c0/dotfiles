def global-mise-upgrade []: nothing -> bool {
    let previous_content: string = open --raw ~/.config/mise/config.toml;
    mise upgrade --cd ~ --bump;
    ($previous_content != (open --raw ~/.config/mise/config.toml))
}

def gh-current-profile [] {
    mise exec -- gh auth status --json hosts
    | from json
    | get hosts
    | values
    | flatten
    | where active
    | first
}

def ignore-message [message: string]: nothing -> nothing { print $"(ansi grey)($message)(ansi reset)" }
def info-message [message: string]: nothing -> nothing { print $"\n(ansi blue)($message)(ansi reset)" }

# Upgrade global mise dependencies and update chezmoi config if needed
def main [] {

    if not (global-mise-upgrade) {
        ignore-message "There is no update"
        return;
    }

    info-message "Commit changes in chezmoi..."
    mise exec -- chezmoi re-add ~/.config/mise/config.toml
    mise exec -- chezmoi git -- restore --staged .
    mise exec -- chezmoi git -- add dot_config/mise/config.toml
    mise exec -- chezmoi git -- commit --message "[mise] update global deps"

    info-message "Push changes to github..."
    let current_gh_profile = gh-current-profile
    let is_not_github_profile: bool = $current_gh_profile.login != "A1c0"

    if $is_not_github_profile { mise exec -- gh auth switch -u A1c0 }

    mise exec -- chezmoi git push

    if $is_not_github_profile { mise exec -- gh auth switch }

}
