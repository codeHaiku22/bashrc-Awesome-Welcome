#!/bin/bash
# Display today's weather forecast for the current region.
wget wttr.in/95816 1&>/dev/null
echo $(date)
head -n 17 95816
rm -f 95816
#Add a nice dad joke.
curl https://icanhazdadjoke.com
echo ''
#echo $(date) > weather.txt
#curl wttr.in/95816 >> weather.txt
#head -n 18 weather.txt
#rm -f weather.txt
