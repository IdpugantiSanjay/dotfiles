if status is-interactive
    # Commands to run in interactive sessions can go here
end

for file in ".conf.d/*.fish"
    if test -f $file
        source $file
    end
end

zoxide init fish | source
starship init fish | source

