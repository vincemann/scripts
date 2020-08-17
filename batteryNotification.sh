#!/bin/bash

# what:
# Sends notification to desktop user, if the battery is low and it's not charging.
# how:
# Extracts information from command 'acpi'
# Checks status of battery by comparing it to given values.
# Sends notification via 'notify-send'
# dependencies:
# libnotify-bin on Debian 

status=$(acpi | cut -f 3 -d ' ' | rev | cut -c 2- | rev)
discharging="Discharging"

current=$(acpi | cut -d " " -f 4 | cut -c 1-2)
minimal=15

if [ "$current" -lt "$minimal" ] && [ "$status" = "$discharging" ]
then
	$(notify-send "Battery low")
fi
