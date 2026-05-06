# Spawn new Node.js project
def new-node-projet [] {
    {name: (pwd | path basename), version: "0.0.0" licence: "MIT"} | save package.json
}

# Join lines with newline
def unlines [] { str join ( char newline ) };
