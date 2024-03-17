#!/usr/bin/env fish

set -l gh_commands "code issues pulls actions profile stars gists home"
complete -f -c gh -a $gh_commands -n "not __fish_seen_subcommand_from $gh_commands" -f
