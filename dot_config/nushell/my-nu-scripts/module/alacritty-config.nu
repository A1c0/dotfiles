def update-file [file: path, closure: closure] {
    open $file
    | do $closure $in
    | save -f $file
};

# Set the windows opacity
export def "window opacity" [
    ratio: float # A value between 1 and 0
] {
    update-file ~/.config/alacritty/alacritty.toml {
         update window.opacity $ratio
    }
}

# Set Windows blur
export def "window blur" [
    blur: bool # If you want blur or not
] {
    update-file ~/.config/alacritty/alacritty.toml {
         update window.blur $blur
    }
}

# Set the font size
export def "font size" [
    size: int # The new size
] {
    update-file ~/.config/alacritty/alacritty.toml {
         update font.size $size
    }
}
