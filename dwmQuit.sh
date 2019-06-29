#!/bin/bash
result=$(printf "yes\nno" | dmenu -i -p "Close dwm?")
result=$(echo "$result" | awk '{print tolower($0)}')
if [ "$result" = "yes" ] || [ "$result" = "y" ]; then
  echo "y"
else
	echo "n"
fi
