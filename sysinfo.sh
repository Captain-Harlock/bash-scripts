#!/bin/bash
#script created by ioef aka Dr_Ciphers
clear

echo -e "Hostname\t:" `hostname`
echo -e "IP\t\t: "`host \`hostname\` | cut -d' ' -f4`
echo -e "System Time\t:" `date +%H:%H:%S`
echo -e "Uptime\t\t:" `uptime | awk '{print $3" "$4}'` | cut -d',' -f1

echo "This is `uname -s` running on a `uname -m` processor."


echo
echo "Memory"
echo "=========================================================================="
free -h | head -2

echo
echo "Disk usage" 
echo "================================================"
df -h


echo
echo "Network Information"
echo "================================================"
echo "DNS" `nslookup ls | grep Server:`

echo
echo "Network Listening Services IPv4"
echo "================================================================================================"
sudo netstat -tupln  | grep "LISTEN" | grep "tcp "


echo
echo "Services"
echo "=========================="
#fetch the running services and redirect the stderr 
#to /dev/null
services=`sudo service --status-all 2>/dev/null`

#check for tor
echo "$services" | grep -q "[ + ] tor"
if [ $? -eq 0 ]; then
    echo "Tor is up and running"
fi

echo "$services" | grep -q "[ + ] nginx"
if [ $? -eq 0 ]; then
    echo "Nginx is up and running"
fi 
