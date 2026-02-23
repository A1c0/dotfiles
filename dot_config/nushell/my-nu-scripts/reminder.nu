# Add reminder
export def add [
  name: string    # the label of reminder
  --at: string    # the time of reminder as format of "HH:mm"
  --for: duration  # the duration of reminder
] {
  if ($at | is-not-empty) {
    open ~/.cache/reminder.nuon
    | append {uuid:(random uuid), name: $name, done_date:($"(date now | $in | format date "%F")T$($at):00" | into datetime)}
    | collect
    | save -f ~/.cache/reminder.nuon
  } else if ($for | is-not-empty) {
    open ~/.cache/reminder.nuon
    | append {uuid:(random uuid), name: $name, done_date:(date now | $in + $for)}
    | collect
    | save -f ~/.cache/reminder.nuon
  }
}

def "nu_complete reminder_uuid" [] { open ~/.cache/reminder.nuon | each {|it|{value: $it.uuid, description: $"($it.name) \(($it.done_date | format date '%Y-%m-%d %H:%M:%S'))"}}}

# Remove Reminder
export def "rm" [
  uuid: string@"nu_complete reminder_uuid" # the uuid of reminder
] {
    open ~/.cache/reminder.nuon
    | where uuid != $uuid
    | collect
    | save -f ~/.cache/reminder.nuon
}

# List all reminders
export def "reminder list" []: nothing -> table { open ~/.cache/reminder.nuon }
