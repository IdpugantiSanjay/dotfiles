function fixup
    git commit --fixup (git log --oneline | fzf | awk '{print $1}')
end
