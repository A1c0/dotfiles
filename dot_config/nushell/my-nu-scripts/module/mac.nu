
export def "dock hide delay" [second: int] {
    defaults write com.apple.dock autohide-delay -float $second
    killall Dock
}

export def restart_superkey [] {
  ps | where name like '(?i)superkey' | first | kill $in.pid;
  ^open /Applications/Superkey.app
}
