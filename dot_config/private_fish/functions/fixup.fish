function fixup
    if git rev-parse --is-inside-work-tree
        set commit_sha (git log --oneline | fzf | awk '{print $1}')
        git commit --fixup $commit_sha
    end
end
