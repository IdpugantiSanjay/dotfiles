#!/usr/bin/env fish

set -l gh_commands "code issues pulls actions profile stars gists home trending"
complete -f -c gh -a $gh_commands -n "not __fish_seen_subcommand_from $gh_commands" -f
