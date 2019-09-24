#!/bin/sh

# A modular status bar for dwm
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Import functions with "$include /route/to/module"
# It is recommended that you place functions in the subdirectory ./bar-functions and use: . "$DIR/bar-functions/dwm_example.sh"

# Store the directory the script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

#./testWeather.sh &

trap 'update' 5

# Change the appearance of the module identifier. if this is set to "unicode", then symbols will be used as identifiers instead of text. E.g. [📪 0] instead of [MAIL 0].
# Requires a font with adequate unicode character support
export IDENTIFIER="unicode"
update() { \
	# So all that big status function was just a command that quicking gets
	# what we want to be the statusbar. This xsetroot command is what sets
	# it. Note that the tr command replaces newlines with spaces. This is
	# to prevent some weird issues that cause significant slowing of
	# everything in dwm. Note entirely sure of the cause, but again, the tr
	# command easily avoids it.
	#xsetroot -name "$(status | tr '\n' ' ')" &

	xsetroot -name "$(dwm_resources)$(dwm_network | tr '\n' ' ')$(dwm_battery)$(dwm_alsa | tr '\n' ' ')$(dwm_weather | tr '\n' ' ' | sed 's/^[ \t]*//;s/[ \t]*$//' )""|$(date "+%Y-%m-%d %a %I:%M %p")"  &
	
	#$(date '+%Y-%m-%d-%H:%M:%S%P')""  &

	# Check to see if new weather report is needed.
	#testweather &
    }

testweather() { 
	[ "$(stat -c %y "$HOME/.local/share/weatherreport" 2>/dev/null | cut -d' ' -f1)" != "$(date )" ] &&
		ping -q -c 1 1.1.1.1 >/dev/null &&
		curl -s "wttr.in/$location" > "$HOME/.local/share/weatherreport" &&
		notify-send "🌞 Weather" "New weather forecast for today."
		./refbar

}

# Import the modules
#. "$DIR/bar-functions/dwm_countdown.sh"
#. "$DIR/bar-functions/dwm_transmission.sh"
#. "$DIR/bar-functions/dwm_cmus.sh"
. "$DIR/bar-functions/dwm_resources.sh"
. "$DIR/bar-functions/dwm_battery.sh"
#. "$DIR/bar-functions/dwm_mail.sh"
. "$DIR/bar-functions/dwm_alsa.sh"
#. "$DIR/bar-functions/dwm_pulse.sh"
. "$DIR/bar-functions/dwm_weather.sh"
#. "$DIR/bar-functions/dwm_vpn.sh"
. "$DIR/bar-functions/dwm_network.sh"
#. "$DIR/bar-functions/dwm_keyboard.sh"
#. "$DIR/bar-functions/dwm_date.sh"

while true
do
    #xsetroot -name "$(dwm_resources)$(dwm_battery)$(dwm_network)$(dwm_alsa)$(dwm_weather)$(dwm_date)"
    #xsetroot -name "$(dwm_resources)$(dwm_battery)$(dwm_alsa)$(dwm_weather)$(dwm_date)" 

    update
	# Sleep for a minute after changing the status bar before updating it
	# again. We run sleep in the background and use wait until it finishes,
    # because traps can interrupt wait immediately, but they can't do that
    # with sleep.
	sleep 30  &
    wait
done
