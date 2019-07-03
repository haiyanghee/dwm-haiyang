#!/bin/bash
result=$(printf "no\nyes" | dmenu -i -p "Close dwm?")
result=$(echo "$result" | awk '{print tolower($0)}')
if [ "$result" = "yes" ] || [ "$result" = "y" ]; then
  printf "y"
else
	printf "n"
fi
