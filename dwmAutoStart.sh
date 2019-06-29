#!/bin/bash
source ~/.bashrc
feh --bg-max $wallpaper
compton &
~/.scripts/lockscreen.sh &
~/.scripts/screenSaverTimeout.sh &
~/.scripts/redshiftopen.sh &
