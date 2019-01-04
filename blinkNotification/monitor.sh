#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

PID=""

# monitor the notifications
su -c "dbus-monitor \"interface='org.freedesktop.Notifications'\"" castello |
while read LINE; do
	# filter only the member field
	RET=`echo $LINE | grep -o 'member=.*'`
	#echo $RET

	if [[ $RET == *"Notify"* ]]; then
		echo "new notify"

		# set notification
		if [[ $PID == "" ]]; then
			echo "set backlight"
			./blink.sh backlight &
			PID=$!
		fi
	fi

	if [[ $RET == *"NotificationClosed"* ]]; then
		echo "notify closed"

		# clear notification
		if [[ $PID != "" ]]; then
			echo "turn off backlight"
			kill $PID
			./blink.sh backlightoff
			PID=""
		fi
	fi
done
