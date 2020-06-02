#!/bin/bash

#Display weather forecast for current time and current day.
curl -s wttr.in/95202 | head -n 17

#Display the date.
echo $(date)
echo ''

#Display system metrics and information.
#End it off with a dad joke. 
domainIP=$(hostname -I | awk '{print $1}')
publicIP=$(curl -s ifconfig.me)
upTime=$(uptime -p)
cpuLong=$(cat /proc/cpuinfo | grep 'model name' | head -n 1)
cpu=$(echo $cpuLong | sed 's/model name : //')
cores=$(cat /proc/cpuinfo | grep cores | head -n 1 | awk '{print "("$4 " " $2")"}')
load=$(uptime | awk -F average: '{print $2}')
memory=$(free -h | grep Mem | awk '{print $3 " / " $2 " ("$3/$2 * 100"%) Usage"}' | sed 's/Gi/G/g')
disk=$(df -H | grep /mnt | awk '{print $3 " / " $2 " ("$3/$2 * 100"%) Usage " $6}')
dadJoke=$(curl -s https://icanhazdadjoke.com)
echo "CPU      :" $cpu" "$cores
echo "Load     :" $load
echo "Memory   :" $memory
echo "Disk     :" $disk
echo "Domain IP:" $domainIP
echo "Public IP:" $publicIP
echo "Uptime   :" $upTime
echo ""
echo $dadJoke
