function m
	# cp "/home/sanjay/.mozilla/firefox/2spjj0ef.default-release/places.sqlite" "/home/sanjay/Documents/places.sqlite"
	set -l db_path "/home/sanjay/Documents/places.sqlite"
	set -l selected (sqlite3 $db_path "select distinct title from moz_bookmarks where title is NOT NULL AND title <> ''  order by title" | gum filter)

	if not test -z $selected
		set -l url (sqlite3 $db_path "
			select url from moz_bookmarks MB
			inner join moz_places MP ON MP.id = MB.fk
			where MB.title LIKE '%$selected%'
		")
		firefox -new-tab $url > /dev/null & disown
	end
end