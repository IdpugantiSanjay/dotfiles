function notify -d 'send notification to ntfy server'
	set timestamp (date "+%Y-%m-%d")
	command cat "/var/log/backup/$timestamp-stdout.txt" | xh ntfy.sh/dexter-backups
end