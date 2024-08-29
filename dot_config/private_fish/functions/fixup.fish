function fixup
    set -l inside_work_tree (git rev-parse --is-inside-work-tree)
    if $inside_work_tree
        set -l commit_sha (git log --oneline | grep -v 'fixup!' | grep -v 'Merge branch .* into .*' | fzf | awk '{print $1}')
        if string length (string trim $commit_sha) > 0
            git commit --fixup $commit_sha
        else
            return 1
        end
    end
end