
set -Ux age_public_key age10fgs4eq2pcvqvfdr9uzm3tqjnc6ppgmcfv9znek0rtu9xgpwr95smg5a0u
set -Ux github_username IdpugantiSanjay

for file in /home/sanjay/.config/fish/conf.d/*
    if test -f $file
        source $file
    end
end


if status is-interactive
    # and not set -q TMUX
    #     tmux
    set -x EDITOR hx
    set -x BROWSER firefox
    # set -U fish_features qmark-noglob
    # set -x BARTIB_FILE "/home/sanjay/Documents/activities.bartib"
    zoxide init fish | source
    starship init fish | source
    direnv hook fish | source
    navi widget fish | source
    fzf --fish | source
    /home/linuxbrew/.linuxbrew/bin/mise activate fish | source

    abbr --add d dexter
    abbr --add u update
    abbr --add --position anywhere lsf '(ls | fzf -m)'
    abbr --add rlsf 'rm (ls | fzf -m)'
    abbr --add src 'source ~/.config/fish/config.fish'
    abbr --add t tmux
    abbr --add g git
    abbr --add bard "pueue add 'firefox gemini.google.com & disown'"
    abbr --add coc 'convco commit'
    # abbr --add lsf "ls | fzf"
    # abbr --add coc convco commit
    # abbr --add j just
    # abbr --add ll ls -la
    # abbr --add dexter ssh dexter
    # abbr --add c chezmoi

    # abbr --add sg s -p github
    # abbr --add sy s -p youtube
    # abbr --add cp cp -i
    # abbr --add ccd chezmoi cd
    # abbr --add .. cd ..
    # abbr --add .. cd ../..
    # abbr --add lg lazygit
    # abbr --add rm rip
    # abbr --add cat bat

    function fish_user_key_bindings
        bind \cl 'clear; commandline -f repaint'
    end

    if not set -q TMUX && [ $hostname = prime ]
        exec tmux 2>/dev/null
    end
end
