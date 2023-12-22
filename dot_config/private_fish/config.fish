


for file in /home/sanjay/.config/fish/conf.d/*
    if test -f $file
        source $file
    end
end

zoxide init fish | source
starship init fish | source
direnv hook fish | source
navi widget fish | source


if status is-interactive
and not set -q TMUX
    tmux
end