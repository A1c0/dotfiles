export def table-without-cache [] {
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

export def table [] {
    table-without-cache
}

export module cache {
    const DB_PATH = path self ./aerospace.db
    const INIT_SQL = path self ./init_aerospace_db.sql

    export def reset [] {
        if ($DB_PATH | path exists) { rm $DB_PATH }

        open $INIT_SQL | sqlite3 $DB_PATH

        let table = table-without-cache
        print $table

        # Display
        $table
        | select monitor display
        | rename id display_id
        | uniq
        | into sqlite --table-name monitor $DB_PATH

        # Workspace
        $table
        | select monitor workspace visible
        | rename monitor_id id
        | into sqlite --table-name workspace $DB_PATH

        # App
        $table
        | select workspace apps
        | flatten apps --all
        | rename --column {id: pid}
        | reject title
        | into sqlite --table-name app $DB_PATH
    }

    export def db [] {
        open $DB_PATH
    }

    export def table [] {
        let query = "
            SELECT
                workspace.id                                AS workspace,
                visible                                     AS visible,
                group_concat((name || ',' || focused), ';') AS apps,
                coalesce(max(focused), 0)                   AS focused,
                display_id                                  AS display
            FROM
                \"workspace\"
                LEFT JOIN \"app\" ON app.workspace = workspace.id
                LEFT JOIN \"monitor\" ON monitor.id = workspace.monitor_id
            GROUP BY
                workspace.id,
                workspace.visible,
                monitor.display_id"

        db
        | query db $query
        | update cells -c [visible focused] {into bool}
        | update apps {if ($in | is-not-empty ) {$in | split row ';' | split column ',' | rename name focused | update focused {into bool}}}
    }
}

