#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "To use LED subsystem bash need be root"
	exit
fi

while [ 1 ]
do

	if [ $1 = "backlight" ]; then
		# this will do a fade effect in my onboard keyboard
		echo 0 > /sys/class/leds/samsung::kbd_backlight/brightness
		sleep 1.7s
		echo 8 > /sys/class/leds/samsung::kbd_backlight/brightness
		sleep 1.5s
	elif [ $1 = "backlightoff" ]; then
		# for turn off backlight
		echo 0 > /sys/class/leds/samsung::kbd_backlight/brightness
		break
	elif [ $1 = "keyboard" ]; then
		# this will blink all LED from my external keyboard
		echo 1 > /sys/class/leds/input8::numlock/brightness
		echo 0 > /sys/class/leds/input8::capslock/brightness
		echo 0 > /sys/class/leds/input8::scrolllock/brightness
		sleep 0.05s
		echo 0 > /sys/class/leds/input8::numlock/brightness
		echo 1 > /sys/class/leds/input8::capslock/brightness
		echo 0 > /sys/class/leds/input8::scrolllock/brightness
		sleep 0.05s
		echo 0 > /sys/class/leds/input8::numlock/brightness
		echo 0 > /sys/class/leds/input8::capslock/brightness
		echo 1 > /sys/class/leds/input8::scrolllock/brightness
		sleep 0.05s
	elif [ $1 = "onboard" ]; then
		# this will blink onboard keyboard capslock LED
		echo 1 > /sys/class/leds/input3::capslock/brightness
		sleep 0.1s
		echo 0 > /sys/class/leds/input3::capslock/brightness
		sleep 0.1s	
	fi
done
