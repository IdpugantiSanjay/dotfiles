status is-interactive; or exit 0

function m
	set -l output "/tmp/$(random)"
	set -l query_result = (cat ~/.config/fish/functions/most_visited.sql | 
	sqlite3 -separator '=%=' ~/.mozilla/firefox/8jhgpwq0.default-release/places.sqlite > $output 2> /dev/null)
	
	# firefox sometimes locks the places.sqlite database with the following error:
	# Parse error near line 1: database is locked (5)
	if test "$status" -eq 1
		# copy places.sqlite to a temp location and query on that file
		command cp ~/.mozilla/firefox/8jhgpwq0.default-release/places.sqlite /tmp/places.sqlite
		set -l query_result = (cat ~/.config/fish/functions/most_visited.sql | sqlite3 -separator '=%=' /tmp/places.sqlite > $output)
	end

	cat $output |
	awk -F '=%=' '{printf "%s\t%s\n", $1,  $2}' | 
	fzf --delimiter '\t' --with-nth 1 --preview 'echo {2}' --bind "enter:become(pueue add '$BROWSER {2} & disown')"

	command rm $output
end


# requirements:
# 1. fzf (dnf)
# 2. sqlite3 (builtin)
# 3. pueue (manual)
# 4. firefox (builtin)