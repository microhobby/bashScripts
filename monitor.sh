#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

# monitor the notifications
su -c "dbus-monitor \"interface='org.freedesktop.Notifications'\"" castello |
while read LINE; do
	# filter only the member field
	RET=`echo $LINE | grep -o 'member=.*'`
	#echo $RET

	if [[ $RET == *"Notify"* ]]; then
		echo "new notify"

		# set notification
		./blink.sh backlight &
		PID=$!
	fi

	if [[ $RET == *"NotificationClosed"* ]]; then
		echo "notify closed"

		# clear notification
		kill $PID
		./blink.sh backlightoff
	fi
done
