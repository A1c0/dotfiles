export def notifications_count [] {
  let notifications = gh api notifications
  | from json
  | get subject
  | where type in ["Issue", "PullRequest", "Release", "CheckSuite"]
  | par-each {
    insert state { |item |
      if ($item.type in ["Issue", "PullRequest"]) {
        let notification = gh api $item.url | from json

        if ($notification.state == "closed") {
          if ($notification | get merged --optional | default false) {
            return 'merged'
          } else {
            return 'closed'
          }
        } else {
          return 'open'
        }
      } else if ($item.type == "CheckSuite") {
        if ($item.title =~ 'workflow run failed') {
          return 'fail'
        }
      }
    }
  | select type state
  };

  if ($notifications | is-not-empty) {
    return ($notifications
    | each {values | str join '_' | str snake-case }
    | group-by --to-table
    | update items { length }
    | rename type count)
  } else {
    return []
  }
}
