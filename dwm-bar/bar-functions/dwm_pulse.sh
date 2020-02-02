#!/bin/sh

# A dwm_bar function to show the master volume of PulseAudio
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: pamixer

dwm_pulse () {
    VOL=$(pamixer --get-volume-human | tr -d '%')
    if [ "$IDENTIFIER" = "unicode" ]; then
        volstat="$(amixer get Master)"
        vol=$(echo "$volstat" | grep -o "\[[0-9]\+%\]" | head -1 |sed 's/[^0-9]*//g')
        #echo $vol

        if [[ ! -z "$(echo "$volstat" | grep -o "\[off\]")" ]]; then
            vol=0
            icon="🔇"
        elif [ "$vol" -gt "70" ]; then
	        icon="🔊"
        elif [ "$vol" -lt "30" ]; then
	        icon="🔈"
        else
	        icon="🔉"
        fi

        printf "%s %s%%\\n" "$icon" "$vol"

    else
        if [ "$VOL" = "muted" ] || [ "$VOL" -eq 0 ]; then
            printf "[MUTE]\n"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "[VOL %s%%]\n" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "[VOL %s%%]\n" "$VOL"
        else
            printf "[VOL %s%%]\n" "$VOL"
        fi
    fi
}

dwm_pulse
