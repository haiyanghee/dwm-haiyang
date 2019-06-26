#!/bin/sh

# A dwm_bar function to show the current network connection/SSID, private IP, and public IP
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: NetworkManager, curl

dwm_network () {

    #CONNAME=$(nmcli -a | grep 'Wired connection' | awk 'NR==1{print $1}')
    #if [ "$CONNAME" = "" ]; then
    #    CONNAME=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -c 5-)
    #fi

    #PRIVATE=$(nmcli -a | grep 'inet4 192' | awk '{print $2}')
    #PUBLIC=$(curl -s https://ipinfo.io/ip)

    #if [ "$IDENTIFIER" = "unicode" ]; then
    #    printf "[🌐 %s %s | %s]\n" "$CONNAME" "$PRIVATE" "$PUBLIC"
    #else
    #    printf "[NET %s %s | %s]\n" "$CONNAME" "$PRIVATE" "$PUBLIC"
    #fi

#		status=$(iwlist wlp0s20f3 scan | grep 'complete\|Quality\|SSID')
#	if [ -z "$status" ]
#		then
#				printf "[⛔]"
#	else
#			#echo $status
#			#status=$(echo $status | awk '{print $1}')
#			#echo $status
#			quality=$(grep 'Quality' <<< $status)
#			twoNum=$(grep  -o '[[:digit:]]*' <<< $quality)
#
#			string=$twoNum
#			#set -f; IFS=' '
#			set -- $string
#			a=$1; b=$2
#			set +f; unset IFS
#			sigquality=$(bc <<< "scale=2; $a / $b")
#			sigquality=$(bc <<< "$sigquality * 100")
#			sigquality=$(echo ${sigquality%.*})	#no decimal
#
#			ssid=$(grep 'SSID' <<< $status)
#			#ssid=$(echo "$ssid" | sed -e "s/^"ESSID:"//" )
#
#			#echo $status
#			#echo $quality
#			#echo  $sigquality
#			#echo $ssid
#			echo  "🌐Quality:" $sigquality " "$ssid
#        	#printf "[🌐 Quality:%s %s]\n" "$sigquality" "$ssid" 
#	fi





	#echo "E:";
	#sed "s/down/⛔/;s/up/🌐/" /sys/class/net/e*/operstate
	ether=$(sed "s/down/⛔/;s/up//" /sys/class/net/e*/operstate)
	echo "E:$ether|" 
	wifi=$(sed "s/down/⛔/;s/up//" /sys/class/net/w*/operstate)
	echo "W:$wifi"; grep "^\s*w" /proc/net/wireless | awk '{ print  int($3 * 100 / 70) "%" }'


}

dwm_network
