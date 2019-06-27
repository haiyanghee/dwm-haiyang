#!/bin/sh

while true
do
		#location="Calgary"
	#[ "$(stat -c %y "$HOME/.local/share/weatherreport" 2>/dev/null | cut -d' ' -f1)" != "$(date )" ] &&
		ping -q -c 1 1.1.1.1 >/dev/null &&
		#curl -s wttr.in/Calgary?format=4 > "$HOME/.local/share/weatherreport"
		curl -s "wttr.in/$location" > "$HOME/.local/share/weatherreport" 
		curl -s "wttr.in/$location?format=4" >> "$HOME/.local/share/weatherreport" 
		~/dwm-haiyang/dwm-bar/refbar
	sleep 15m
done
