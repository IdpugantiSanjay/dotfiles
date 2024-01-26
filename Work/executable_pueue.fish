#! /home/linuxbrew/.linuxbrew/bin/fish

# set -a DBUS_SESSION_BUS_ADDRESS "unix:path=/run/user/$(id -u)/bus"
pueue start
sleep 10
pueue add 'while true; do
            notify-send "$(bartib -f /home/sanjay/Documents/activities.bartib current)"
            sleep 1800
            done
'
