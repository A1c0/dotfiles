# Flat record
def flatten-record [
    --separator: string = "."  # Key Separator (default to ".")
] {
    let record: record = $in
    def flatten-helper [prefix: string, data: any] {
        if ($data | describe) =~ "record" {
            $data | items {|key, value|
                let new_prefix = if ($prefix | is-empty) {
                    $key
                } else {
                    $"($prefix)($separator)($key)"
                }
                flatten-helper $new_prefix $value
            } | flatten
        } else {
            [{key: $prefix, value: $data}]
        }
    }

    flatten-helper "" $record
    | reduce --fold {} {|item, acc|
        $acc | insert $item.key $item.value
    }
}
