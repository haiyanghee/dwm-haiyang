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
	CPU1=$(sensors | grep -i "Core 0:" | awk '{print $3}' | cut -d '+' -f 2 ) 
	CPU1=${CPU1::-4}
	CPU2=$(sensors | grep -i "Core 1:" | awk '{print $3}') 
	CPU2=${CPU2::-4}
	CPU3=$(sensors | grep -i "Core 2:" | awk '{print $3}') 
	CPU3=${CPU3::-4}
	CPU4=$(sensors | grep -i "Core 3:" | awk '{print $3}') 
	CPU4=${CPU4::-4}
	CPU=$((CPU1+CPU2+CPU3+CPU4))
	CPU=$((CPU / 4))
	CPU=${CPU:0:3}°C

	load=$(uptime | grep load | awk '{print $9}')
	load=${load::-1}

    # Used and total storage in /home (rounded to 1024B)
    STOUSED=$(df -h | grep '/sda5' | awk '{print $3}')
    STOTOT=$(df -h | grep  '/sda5' | awk '{print $2}')
    STOPER=$(df -h | grep  '/sda5' | awk '{print $5}')

    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "💻 MEM: %s/%s|CPU: %s|Load: %s|STO: %s/%s: %s|\n" "$MEMUSED" "$MEMTOT" "$CPU" "$load" "$STOUSED" "$STOTOT" "$STOPER"
    else
        printf "[STA | MEM %s/%s CPU %s STO %s/%s: %s]\n" "$MEMUSED" "$MEMTOT" "$CPU" "$STOUSED" "$STOTOT" "$STOPER"
    fi
}

dwm_resources
