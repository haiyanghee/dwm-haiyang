#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_resources () {
    # Used and total memory
    MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
    MEMTOT=$(free -h |awk '(NR == 2) {print $2}')
    # CPU temperature

	#For dell intel cpu:
	#cpuAll=$(sensors | grep "Core" | awk '{print $3}' | tr -d '°C+' | tr '\n' ' ' )
	#CPU1=$(echo $cpuAll | awk '{print $1}')
	#CPU2=$(echo $cpuAll | awk '{print $2}')
	#CPU3=$(echo $cpuAll | awk '{print $3}')
	#CPU4=$(echo $cpuAll | awk '{print $4}')

	#CPUTEMP=$(echo "($CPU1+$CPU2+$CPU3+$CPU4)"/4 |bc)

	#For thinkpad amd cpu:
	CPUTEMP=$(sensors | grep "Tdie" | awk '{print $2}' | tr -d '°C+' | tr '\n' ' ' )

	percent=$(mpstat | awk '{print $13}' | tr '\n' ' ' | awk '{print (100 - $2 ) "%"}')
	#percent=$(mpstat | awk '{print $4}' | tr '\n' ' ' | awk '{print $3 "%"}')

    # Used and total storage in /home (rounded to 1024B)
    STOUSED=$(df -h | grep '/nvme0n1p5' | awk '{print $3}')
    STOTOT=$(df -h | grep  '/nvme0n1p5' | awk '{print $2}')
    STOPER=$(df -h | grep  '/nvme0n1p5' | awk '{print $5}')

        printf "MEM: %s/%s|CPU: %s, %s°C|STO: %s/%s %s|\n" "$MEMUSED" "$MEMTOT" "$percent" "$CPUTEMP"  "$STOUSED" "$STOTOT" "$STOPER"
}

dwm_resources
