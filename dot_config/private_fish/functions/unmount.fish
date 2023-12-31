function unmount
	if mountpoint $HOME/network-drives > /dev/null
		sudo umount $HOME/network-drives/
	else
		echo 'Nothing mounted on $HOME/network-drives'
	end
end