export def log [...args] {
  let items = $args | reduce { |a, b| $b | append " " | append $a }
  if ("SKETCHYBAR_LOGGER_LABEL" in $env ) {
    print $"(ansi grey)[($env.SKETCHYBAR_LOGGER_LABEL)(ansi grey)](ansi reset)" " " $items (char newline) --no-newline --raw
  } else {
    print ...$args
  }
}

