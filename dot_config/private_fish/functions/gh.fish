function gh
    set -l username 'IdpugantiSanjay'
    set -l repo (command gh repo list --json 'name' -q '.[].name' | fzf)
    if not test -z $repo
        set -l url "https://github.com/$username/$repo"
        pueue add "$BROWSER $url & disown"
    end
end