function fzf_kill_process
    set selection (ps -eo pid,cmd --no-headers | \
        fzf --multi --preview 'echo {}')

    if test -n "$selection"
        echo $selection | awk '{print $1}' | xargs kill -9
    end
end
