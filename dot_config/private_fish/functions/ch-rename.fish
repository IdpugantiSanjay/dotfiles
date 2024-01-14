function ch-rename -a toc
	sed -i 's/\r//g' $toc

	if not test -f $toc
		echo "$toc not found or it's not a file"
		return 
	end

	set -l lesson_number 1
	for lesson in (cat $toc)
		set lesson (string replace "'" "" $lesson)
		set lesson (string replace "`" "" $lesson)
		set lesson (string replace '"' "" $lesson)
		set lesson (string replace ',' "" $lesson)
		set lesson (string replace '^' "" $lesson)
		set lesson (string replace '.' "" $lesson)
		
		set -l new_name (string pad -w 3 --char '0' $lesson_number).$lesson.mp4
		echo "lesson$lesson_number -> $new_name"
		mv "./lesson$lesson_number.mp4" "$new_name"
		set lesson_number (math $lesson_number + 1)
	end
end