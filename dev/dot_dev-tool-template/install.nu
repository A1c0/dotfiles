const TOOL_DB_PATH = path self ./tooldb.nuon

def install_node_if_required [tools: list<string> ] {
    let is_some_npm_deps: bool = $tools | any { "npm" in $in}
    let is_node_missing: bool = which node | is-empty
    let node_is_needed: bool = $is_node_missing and $is_some_npm_deps

    if $node_is_needed {
        mise use --env local node@lts
    }
}

def main [] {
    let tools = open $TOOL_DB_PATH | input list --multi --display name "Choose with tools you need:"

    install_node_if_required $tools.tool

    $tools | select tool pin_version | each {|item|
        let pin_version: string = $item.pin_version | if ($in | is-not-empty ) {"@" + $in } | default ""
        $item.tool + $pin_version
    }
    | ^mise use --env local ...$in
}
