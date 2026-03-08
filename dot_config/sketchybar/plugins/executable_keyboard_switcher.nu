#!/usr/bin/env nu
use std
use ../utils/logger.nu
$env.SKETCHYBAR_LOGGER_LABEL = $"(ansi grey)keyboard_switcher(ansi grey)"

def main [] {
  let current_app: string = do --ignore-errors {$env.INFO} | default ""

  match $current_app {
    "Ghostty" | "Webstorm" | "Alacritty" => {keyboardSwitcher select "French dev" o+e> (std null-device); logger log $"($current_app) -> French dev" }
    _ => {keyboardSwitcher select "French" o+e> (std null-device) ; logger log $"($current_app) -> French" }
  }
}
