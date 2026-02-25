set -Ux age_public_key age10fgs4eq2pcvqvfdr9uzm3tqjnc6ppgmcfv9znek0rtu9xgpwr95smg5a0u
set -Ux github_username IdpugantiSanjay
set -gx TRAEFIK_PASSWORD 18483af2ba30a956

for file in /home/sanjay/.config/fish/conf.d/*
    if test -f $file
        source $file
    end
end

if status is-interactive
    # and not set -q TMUX
    #     tmux
    # set -gx SSH_AUTH_SOCK "/home/$USER/.bitwarden-ssh-agent.sock"
    set -gx AGE_YUBIKEY_BLACK_RECIPIENT age1yubikey1q23v9tnfz7f0y0r8rnpv570z5z8kzwny9u2fudqysugkqf0092w3s6ueu9q
    # set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/yubikey-agent/yubikey-agent.sock"
    set -x EDITOR hx
    set -x BROWSER firefox
    # set -U fish_features qmark-noglob
    # set -x BARTIB_FILE "/home/sanjay/Documents/activities.bartib"
    zoxide init fish | source
    starship init fish | source
    # direnv hook fish | source
    # navi widget fish | source
    fzf --fish | source

    abbr --add d dexter
    abbr --add u update
    abbr --add --position anywhere lsf '(ls | fzf -m)'
    abbr --add src 'source ~/.config/fish/config.fish'
    abbr --add g git

    # abbr --add gemini "xdg-open https://gemini.google.com"
    abbr --add coc 'convco commit'
    abbr --add allow 'direnv allow .'
    abbr --add rlf 'readlink -f '

    abbr --add svc services
    # abbr --add ls 'ls --hyperlink'
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

    function fish_command_not_found
        # do nothing
    end

    bind \ck fzf_kill_process

    # atuin init fish | source
    # command cat ~/.pending-tasks
    # if not set -q TMUX && [ $hostname = prime ]
    #     exec tmux 2>/dev/null
    # end
end

# pnpm
set -gx PNPM_HOME "/home/sanjay/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

/home/sanjay/.local/bin/mise activate fish | source # added by https://mise.run/fish
fx --comp fish | source
