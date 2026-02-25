function fzf_kill_process
    set pid (ps -eo pid,cmd --no-headers | fzf -m | awk '{print $1}')
    if test -n "$pid"
        echo $pid | xargs kill -9
    end
end
