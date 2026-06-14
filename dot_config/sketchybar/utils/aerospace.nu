export def table [] {
    let visible_workspaces = aerospace list-workspaces --monitor all --visible | lines
    let focused_workspace = aerospace list-workspaces --focused
    let monitor_table = aerospace list-monitors --json
    | from json
    | select monitor-id
    | rename monitor
    | insert workspace {
        aerospace list-workspaces --monitor $in.monitor
        | lines
    }
    | flatten

    let display_monitor_table = sketchybar --query displays
    | from json
    | insert sort-value { $in.frame.x + $in.frame.y }
    | sort-by sort-value
    | enumerate
    | rename id
    | update id {$in + 1}
    | flatten
    | rename monitor display
    | select monitor display

    let focused_window_id = try {aerospace list-windows --focused --json | from json | get 0.window-id}

    let app_table = aerospace list-workspaces --monitor all --empty no
    | lines
    | wrap workspace
    | par-each {
        insert apps {
            aerospace list-windows --workspace $in.workspace --json
            | from json
            | insert focused {$in.window-id == $focused_window_id}
            | rename name id title focused
        }
    }
    $monitor_table
    | join -l $display_monitor_table monitor
    | join -l $app_table workspace
    | each {|it|
        $it
        | insert visible {$it.workspace in $visible_workspaces}
        | insert focused {$it.workspace == $focused_workspace}
    } | default [] apps;
}

export module cache {
    const CACHE_PATH = path self ./aerospace.db
    const INIT_SQL = path self ./init_aerospace_db.sql

    export def reset [] {
        if ($CACHE_PATH | path exists) { rm $CACHE_PATH }
        open $INIT_SQL | sqlite3 $CACHE_PATH

        let table = table

        # Display
        $table
        | select monitor display
        | rename id display_id
        | uniq
        | into sqlite --table-name monitor aerospace.db

        # Workspace
        $table
        | select monitor workspace visible
        | rename monitor_id id
        | into sqlite --table-name workspace aerospace.db

        # App
        $table
        | select workspace apps
        | flatten apps --all
        | rename --column {id: pid}
        | reject title
        | into sqlite --table-name app aerospace.db
    }

    export def db [] {
        open $CACHE_PATH
    }
}

