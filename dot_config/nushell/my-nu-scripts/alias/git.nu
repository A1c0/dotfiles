def git-current-branch [] {git rev-parse --abbrev-ref HEAD | str trim}
def git-previous-branch [] {git rev-parse --symbolic-full-name @{-1} | str trim}

alias gst = git status
alias grhh = git reset --hard
alias gfa = git fetch --all
alias gaa = git add --all
alias gco = git checkout

def gcam [msg: string] { git commit --all --message $msg }
def ggl [] { git pull --rebase origin (git-current-branch) }
def ggp [] { git push origin (git-current-branch) }
def ggfl [] { git push --force-with-lease origin (git-current-branch) }
def groh [] { git reset --hard $"origin/(git-current-branch)" }
def gpsup [] { git push --set-upstream origin (git-current-branch) }

def gstf [] {
    let files_modified = gst -s | lines | split column ' ' --collapse-empty | rename flag name;
    let files_modified_ls_info = $files_modified | get name | par-each {ls --long $in | first};

    $files_modified | join $files_modified_ls_info name | select flag name created accessed modified;
}

