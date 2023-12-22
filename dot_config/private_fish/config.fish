if status is-interactive
    # Commands to run in interactive sessions can go here
end


for file in /home/sanjay/.config/fish/conf.d/*
    if test -f $file
        source $file
    end
end

zoxide init fish | source
starship init fish | source
direnv hook fish | source
navi widget fish | source
