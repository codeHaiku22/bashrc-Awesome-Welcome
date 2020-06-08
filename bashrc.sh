#Display weather forecast for current time and current day.
curl -s wttr.in/95356 | head -n 17

#Display the date.
echo $(date)
echo ''

#Display system metrics and information. 
domainIP=$(hostname -I | awk '{print $1}')
publicIP=$(curl -s ifconfig.me)
upTime=$(uptime -p | sed 's/up//')
distro=$(cat /etc/issue | awk '{print $1 " " $2 " " $3}')
kernel=$(uname -a | awk '{print $3}')
cpuLong=$(cat /proc/cpuinfo | grep 'model name' | head -n 1)
gpu=$(lspci | grep VGA | awk -F controller: '{print $2}')
cpu=$(echo $cpuLong | sed 's/model name : //')
cores=$(cat /proc/cpuinfo | grep cores | head -n 1 | awk '{print "("$4 " " $2")"}')
load=$(uptime | awk -F average: '{print $2}')
memoryPct=$(printf '%.1f\n' $(free | grep Mem | awk '{print ($3/$2 * 100)}'))
memory=$(free -h | grep Mem | awk '{print $3 " / " $2}' | sed 's/Gi/G/g')

echo "Distro          :" $distro
echo "Kernel          :" $kernel
echo "CPU             :" $cpu" "$cores
echo "Load            :" $load
echo "GPU             :" $gpu
echo "Memory          :" $memory "("$memoryPct"%) Usage"
df -H | sort -h | grep /dev/sd | while read disk; do
  mountEntry=$(echo $disk | awk '{print $1}')
  mountUsage=$(echo $disk | awk '{print $3 " / " $2}')
  mountPct=$(echo $disk | awk '{print $5}')
  echo  "Disk ["$mountEntry"]: "$mountUsage " ("$mountPct") Usage";
done
echo "Domain IP       :" $domainIP
echo "Public IP       :" $publicIP
echo "Uptime          :" $upTime
echo ""

#End if off with a dad joke.
curl -s https://icanhazdadjoke.com
echo ""
