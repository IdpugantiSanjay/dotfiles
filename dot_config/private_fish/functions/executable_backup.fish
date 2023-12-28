#!/usr/bin/env fish

function backup -d 'backup script using rsync' -a source_dir destination_dir
	if not test -d $source_dir 
		echo "$source_dir does not exist or is not a directory"
		return
	end
	
	if not test -d $destination_dir
		mkdir -p $destination_dir
	end
	
	set timestamp (date "+%Y-%m-%d")
	rsync -a --backup --delete --recursive --verbose --backup-dir="$destination_dir Backups/$timestamp" $source_dir $destination_dir >> "/var/log/backup/$timestamp-stdout.txt" 2>> "/var/log/backup/$timestamp-stderr.txt"
end
