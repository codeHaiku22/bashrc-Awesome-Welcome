#Display weather forecast for current time and current day.
curl -s wttr.in/90210 | head -n 17

#Display the date.
echo $(date)
echo ''

#Display system metrics and information.
create_usage_line(){
  local dashes="##############################"
  local blanks="------------------------------"
  local lenDashes=$(echo $dashes | awk '{print length}')
  local dashCnt=$(echo $(($lenDashes * $1/100)))                  #Here's one way to do a calculation using (( ))
  local blankCnt=$(echo "scale=0; "$lenDashes"-"$dashCnt | bc)    #Here's another way to do a calculation using bc
  local dashLine=$(printf "%"$dashCnt"."$dashCnt"s" $dashes)
  local blankLine=$(printf "%"$blankCnt"."$blankCnt"s" $blanks)
  echo "["$dashLine"$blankLine]" $1"%"
}

hostname=$(hostname)
distro=$(cat /etc/issue | awk '{print $1 " " $2 " " $3}')
kernel=$(uname -a | awk '{print $3}')
cpuLong=$(cat /proc/cpuinfo | grep 'model name' | head -n 1)
cpu=$(echo $cpuLong | sed 's/model name : //')
cores=$(cat /proc/cpuinfo | grep cores | head -n 1 | awk '{print "("$4 " " $2")"}')
load=$(uptime | awk -F average: '{print $2}')
cpuPct=$(printf '%.0f\n' $(grep 'cpu ' /proc/stat | awk '{print ($2+$4)*100/($2+$4+$5)}'))
gpu=$(lspci | grep VGA | awk -F controller: '{print $2}')
memoryPct=$(printf '%.0f\n' $(free | grep Mem | awk '{print ($3/$2 * 100)}'))
memory=$(free -h | grep Mem | awk '{print $3 " / " $2}' | sed 's/Gi/G/g')
domainIP=$(hostname -I | awk '{print $1}')
publicIP=$(curl -s ifconfig.me)
upTime=$(uptime -p | sed 's/up//')

echo "Hostname        :" $hostname
echo "Distro          :" $distro
echo "Kernel          :" $kernel
echo "CPU Info        :" $cpu" "$cores
echo "CPU Load        :" $load
echo "GPU             :" $gpu
echo "Domain IP       :" $domainIP
echo "Public IP       :" $publicIP
echo "Uptime          :" $upTime
echo ""
echo "CPU             :" $(create_usage_line $cpuPct)
echo "Memory          :" $(create_usage_line $memoryPct)"     "$memory

df -H | sort -h | grep /dev/sd | while read disk; do
  mountEntry=$(echo $disk | awk '{print $1}')
  mountUsage=$(echo $disk | awk '{print $3 " / " $2}')
  mountPct=$(echo $disk | awk '{print $5}' | sed 's/%//g')
  #echo "Disk ["$mountEntry"]: "$mountUsage " ("$mountPct") Usage";
  echo "Disk ["$mountEntry"]: "$(create_usage_line $mountPct)"     "$mountUsage
done
echo ""

#End it off with a dad joke.
curl -s https://icanhazdadjoke.com
echo ""
