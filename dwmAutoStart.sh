#!/bin/bash
source ~/.zshrc
#sudo ~/.scripts/disable-usb-trigger-wakeup.sh &
#sudo ~/.scripts/reloadPsmouse.sh &

sudo ~/.scripts/hdmi-thinkpad.sh &
sudo ~/.scripts/connectToWifi.sh &
~/dwm-haiyang/dwm-bar/dwm_bar.sh &
#sudo ~/.scripts/keyboard.sh &
feh --bg-max $wallpaper
compton &
~/.scripts/normalScreenSaverTimeout.sh &
~/.scripts/redshiftopen.sh &
~/dwm-haiyang/dwm-bar/testWeather.sh &	#read the weather
