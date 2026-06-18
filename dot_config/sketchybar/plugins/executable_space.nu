#!/usr/bin/env nu

use ../utils/icon.nu;
use ../utils/color.nu;
use ../utils/aerospace.nu;
use ../utils/logger.nu;
$env.SKETCHYBAR_LOGGER_LABEL = $"(ansi blue)space(ansi reset)"


def render_visible_workspace [item, table] {
    let display = $item.display;
    let workspace = $item.workspace;
    let is_focused = $item.focused;

    let focused_app = $item | get apps | where focused | get 0.name --optional | if ($in | is-not-empty ) {icon from name}
    let unfocused_apps = $item | get apps | where focused == false | get name | each {icon from name} | str join ''
    let border_width = if $is_focused { 2 } else { 1 }

    let workspace_option = [
        --set $"focused_space.($display).label" icon=($workspace)
        --set $"focused_space.($display).focused_app" label=($focused_app) drawing=($focused_app | is-not-empty)
        --set $"focused_space.($display).unfocused_apps" label=($unfocused_apps) drawing=($unfocused_apps | is-not-empty)

        --set $"focused_space.($display).panel" background.border_width=($border_width),
                                                background.border_color=( if $is_focused { color mocha mauve } else { color mocha text } )
                                                background.height=( 25 + $border_width )
        --move $"focused_space.($display).label" after $"space.($workspace)"
        --move $"focused_space.($display).focused_app" after $"focused_space.($display).label"
        --move $"focused_space.($display).unfocused_apps" after $"focused_space.($display).focused_app"
        --move $"focused_space.($display).panel" after $"focused_space.($display).unfocused_apps"
    ]

    $workspace_option
}

def render_workspace [
    --only_workspaces: list<string>
    --cache # use cache
] {
    let res = timeit --output { if $cache { aerospace cache table } else {aerospace table }}
    let aerospace_table = $res.output;
    # print $'aerospace table: ($res.time)'

    let options = if ($only_workspaces | is-not-empty) {
        $aerospace_table
        | where workspace in $only_workspaces
    } else {
        $aerospace_table
    }
    | par-each {|space|
        let sid = $"space.($space.workspace)"
        if $space.visible {
            return ( render_visible_workspace $space $aerospace_table | prepend [ --set $sid drawing=off ] )
            } else {
            if ($space.apps | is-empty) {
                return [--set, $sid, drawing=off]
            } else {
                return [ --set, $sid, label=($space.apps | get name | each {icon from name} | str join),
                                      icon.color=(color mocha text --alpha 0.8),
                                      label.color=(color mocha text --alpha 0.8),
                                      background.color=(color mocha base --alpha .6),
                                      background.border_width=0,
                                      display=($space.display),
                                      drawing=on,
                ]
            }
        }
    }

    let all_options = $options | flatten --all
    sketchybar ...$all_options
}


def on-aerospace-workspace-change [focused:string, previous:string] {
    # let focused = aerospace list-windows --focused --json | from json | first | select app-name window-id | rename name pid
    # aerospace cache db | query db $""
    # render_workspace --only_workspaces [$focused $previous] --cache
}

def on-space-windows-change [info: string] {
    # TODO comment savoir quand c'est un delete ou un create
    print on-space-windows-change $info
    aerospace cache reset
    render_workspace
}

def on-front-app-switched [] {
    let focused = aerospace list-windows --focused --json | from json | first | select app-name window-id | rename name pid
    aerospace cache db | query db $"update app set focused = true where pid = ($focused.pid)"
    print on-front-app-switched $focused
    render_workspace --cache
}

def on-aerospace-monitor-move [monitor: int] {
    print on-aerospace-monitor-move $monitor
    aerospace cache reset
    render_workspace
}

def on-aerospace-workspace-move [workspace: string] {
    let focused_pid = aerospace list-windows --focused --json | from json | first | get window-id
    let query = $"update app set workspace = '($workspace)' where pid = ($focused_pid)"
    print $query
    aerospace cache db | query db $query

    print on-aerospace-workspace-move $workspace
    render_workspace --cache
}

def on-forced [] {
    aerospace cache reset
    render_workspace
}

def main [] {
    let process_duration: duration = timeit {
        match $env.SENDER {
            'aerospace_workspace_change' => { on-aerospace-workspace-change $env.AEROSPACE_FOCUSED_WORKSPACE $env.AEROSPACE_PREV_WORKSPACE },
            'space_windows_change' => { on-space-windows-change $env.INFO }
            'front_app_switched' => { on-front-app-switched }
            'aerospace_monitor_move' => {on-aerospace-monitor-move $env.MONITOR}
            'aerospace_workspace_move' => {on-aerospace-workspace-move $env.WORKSPACE}
            'forced' => { on-forced }
            _ => {render_workspace}
        }
    }
    logger log $env.SENDER $process_duration
}
