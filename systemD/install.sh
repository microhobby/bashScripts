#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "To install systemD service we need to be root"
	exit
fi

cp $1.service /lib/systemd/system/
systemctl start $1
systemctl status $1
systemctl enable $1
