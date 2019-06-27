#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_resources () {
    # Used and total memory
    MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
    MEMTOT=$(free -h |awk '(NR == 2) {print $2}')
    # CPU temperature
    #CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)

	#CPU1=$(sensors | grep -i "Core 0:" | awk '{print $3}' | cut -d '+' -f 2 ) 
	#CPU1=${CPU1::-4}
	#CPU2=$(sensors | grep -i "Core 1:" | awk '{print $3}') 
	#CPU2=${CPU2::-4}
	#CPU3=$(sensors | grep -i "Core 2:" | awk '{print $3}') 
	#CPU3=${CPU3::-4}
	#CPU4=$(sensors | grep -i "Core 3:" | awk '{print $3}') 
	#CPU4=${CPU4::-4}
	cpuAll=$(sensors | grep "Core" | awk '{print $3}' | tr -d '°C+' | tr '\n' ' ' )
	CPU1=$(echo $cpuAll | awk '{print $1}')
	CPU2=$(echo $cpuAll | awk '{print $2}')
	CPU3=$(echo $cpuAll | awk '{print $3}')
	CPU4=$(echo $cpuAll | awk '{print $4}')

	CPU=$(echo "($CPU1+$CPU2+$CPU3+$CPU4)"/4 |bc)

	#load=$(uptime | grep load | awk '{print $9}')
	#load=${load::-1}

	percent=$(mpstat | awk '{print $13}' | tr '\n' ' ' | awk '{print (100 - $2 ) "%"}')

    # Used and total storage in /home (rounded to 1024B)
    STOUSED=$(df -h | grep '/sda5' | awk '{print $3}')
    STOTOT=$(df -h | grep  '/sda5' | awk '{print $2}')
    STOPER=$(df -h | grep  '/sda5' | awk '{print $5}')

        printf "💻 MEM: %s/%s|CPU: %s%%, used: %s|STO: %s/%s: %s|\n" "$MEMUSED" "$MEMTOT" "$CPU" "$percent" "$STOUSED" "$STOTOT" "$STOPER"
}

dwm_resources
