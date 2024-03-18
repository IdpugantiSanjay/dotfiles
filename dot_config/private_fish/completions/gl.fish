#!/usr/bin/env fish

set -l gl_commands "issues pipelines"
complete -f -c gl -a $gl_commands -n "not __fish_seen_subcommand_from $gl_commands" -f