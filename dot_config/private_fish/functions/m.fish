status is-interactive; or exit 0

function m
	cat ~/.config/fish/functions/most_visited.sql | 
	sqlite3 -separator '=%=' ~/.mozilla/firefox/8jhgpwq0.default-release/places.sqlite |
	awk -F '=%=' '{printf "%s\t%s\n", $1,  $2}' | 
	fzf --delimiter '\t' --with-nth 1 --preview 'echo {2}' --bind "enter:become(pueue add '$BROWSER {2} & disown')"
end


# requirements:
# 1. fzf (dnf)
# 2. sqlite3 (builtin)
# 3. pueue (manual)
# 4. firefox (builtin)