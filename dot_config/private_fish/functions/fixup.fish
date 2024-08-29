function fixup
    # check if function is being run inside a git repo
    set -l inside_work_tree (git rev-parse --is-inside-work-tree)
    if $inside_work_tree
        # if inside git repo get git commit sha in one line 
        set -l commit_sha (git log --oneline | grep -v 'fixup!' | grep -v 'Merge branch .* into .*' | fzf | awk '{print $1}')
        # if commit_sha has string value fixup that commit
        if test -n $commit_sha
            git commit --fixup $commit_sha
        else
            return 1
        end
    end
end