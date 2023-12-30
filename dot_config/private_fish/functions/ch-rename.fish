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
		
		echo "lesson$lesson_number -> $lesson.mp4"
		mv "./lesson$lesson_number.mp4" "$lesson.mp4"
		set lesson_number (math $lesson_number + 1)
	end
end