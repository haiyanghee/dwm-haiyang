#!/bin/bash
source ~/.bashrc
sudo ~/.scripts/startup.sh &
feh --bg-max $wallpaper
compton &
~/.scripts/screenSaverTimeout.sh &
~/.scripts/redshiftopen.sh &
~/dwm-haiyang/dwm-bar/testWeather.sh &	#read the weather
