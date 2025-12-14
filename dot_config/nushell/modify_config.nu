#!/usr/bin/env -S nu --stdin

def main [] {
  let current: string = $in | collect
  let template = (open --raw ('~/.local/share/chezmoi' | path expand | path join dot_config nushell base_config.nu))
  let extra: string = $current | parse -r '(?<=# END_OF_CHEZMOI_MANAGED\n)(?<content>.*(\n.*)*)' | get 0.content --optional
  # print --stderr extra $extra
  print $"($template)($extra | str replace -r "\n$" '')"
}
