function gl -a navigation
    set -l url
    set -l repo_navigations issues pipelines

    set -l project_url (glab project list --mine -F json | jq -r '.[].web_url' | fzf --exact)
    
    switch $navigation
    case issues
        set project_url (printf '%s/-/issues' $project_url)
    case pipelines 
        set project_url (printf '%s/-/pipelines' $project_url)
    end
    
    if not test -z $project_url
        pueue add "$BROWSER $project_url & disown"
    end
end