function gh -a navigation
    set -l url
    set -l repo_navigations code issues pulls actions


    if contains $navigation $repo_navigations || test -z $navigation
        set repo (command gh repo list --json 'name' -q '.[].name' | fzf)
        if not test -z $repo
            set url "https://github.com/$github_username/$repo/$navigation"
            pueue add "$BROWSER $url & disown"
        end
        return 0
    end


    switch $navigation
    case profile
        set url "https://github.com/$github_username"
    case stars
        set url "https://github.com/$github_username?tab=stars"
    case gists
        set url "https://gist.github.com/$github_username"
    case home
        set url "https://github.com"
    case '*'
        echo "Error: $argv[1] is not a valid navigation" >&2
        return 1
    end

    if not test -z $url
        pueue add "$BROWSER $url & disown"
    end
end