#!/usr/bin/env fish

function backup -d 'backup script using rsync' -a source_dir destination_dir
	if not test -d $source_dir 
		echo "$source_dir does not exist or is not a directory"
		return
	end
	
	if not test -d $destination_dir
		echo "$destination_dir does not exist or is not a directory"
		return
	end

	set timestamp (date "+%Y-%m-%d")
	rsync -a --backup --delete --recursive --verbose --backup-dir="$destination_dir/$timestamp" $source_dir $destination_dir
end
