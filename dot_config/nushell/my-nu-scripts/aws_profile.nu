def aws_profile [] {open $"($env.HOME)/.aws/config" | lines | parse "[profile {profile}]" | get profile };

export def "current" [] {
    aws sts get-caller-identity | str replace --all --regex '\n\s*' '' | from json
}

export def --env "switch" [profile: string@aws_profile] {
    if $profile == "default" {
        hide-env AWS_PROFILE
    } else {
        $env.AWS_PROFILE = $profile;
    }
}
