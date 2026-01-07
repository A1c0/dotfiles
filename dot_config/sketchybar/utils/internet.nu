export def 'there_is_internet' []: nothing -> bool {

  do --ignore-errors {
    http get --full http://connectivitycheck.gstatic.com/generate_204
    | get status
    | $in == 204
  }
  | default false
}

export def 'there_is_not_internet' []: nothing -> bool  {
  not (there_is_internet)
}
