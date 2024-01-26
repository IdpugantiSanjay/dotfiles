set -l commands "cancel check continue current edit help last list projects report start stop"

complete -c bartib -f
complete -c bartib -n "not __fish_seen_subcommand_from $commands" -a "$commands"
