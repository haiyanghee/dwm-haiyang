#!/bin/sh

while true
do
		location="卡尔加里"
	#[ "$(stat -c %y "$HOME/.local/share/weatherreport" 2>/dev/null | cut -d' ' -f1)" != "$(date )" ] &&
		ping -q -c 1 1.1.1.1 >/dev/null &&
		#curl -s wttr.in/Calgary?format=4 > "$HOME/.local/share/weatherreport"
		curl -s "zh.wttr.in/$location" > "$HOME/.local/share/weatherreport" 
		curl -s "zh.wttr.in/$location?format=4" >> "$HOME/.local/share/weatherreport" 
		notify-send "🌞 Weather" "New weather forecast for today."
		~/dwm-haiyang/dwm-bar/refbar
	sleep 15m
done
