
def "from tsc" []: string -> table {
    ansi strip
    | parse -r '(?<file>.*?)\((?<line>\d+),(?<carret>\d+)\): error (?<code>TS\d+):(?<error>.*)'
}

def "from env" []: string -> record {
    parse -r '^(\s*(?<key>[^\=#]+))="?(?<value>.*?)"?$'
    | select key value
    | transpose -rd
}
