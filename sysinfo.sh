#!/bin/bash
#script created by ioef aka Dr_Ciphers
clear


echo -e "Hostname\t:" `hostname`
echo -e "IP\t\t: "`host \`hostname\` | cut -d' ' -f4`
echo -e "System Time\t:" `date +%H:%H:%S`
echo -e "Uptime\t\t:" `uptime | awk '{print $3" "$4}'` | cut -d',' -f1 

#acquire the username of the logged in user
getwhoami=`whoami`
#acquire the OS and store it for futher usage
OS=`uname -s`

echo -e "username\t:" $getwhoami
if [ "$OS" == "OpenBSD" ]; then
    echo -e "Lastlog\t\t:" `last | grep $getwhoami | grep "still"`
fi

if [ "$OS" == "Linux" ]; then
    echo -e "Lastlog\t\t:" `lastlog | grep $getwhoami | cut -d' ' --complement -f1`
fi
echo -e "Groups\t\t:" `groups`
echo -e "working dir\t: "`pwd`

echo

echo "CPU"
echo "=========================================================================="

echo "This is `uname -s` running on a `uname -m` processor."

if [ "$OS" == "Linux" ]; then
   echo "CPU Model:" `cat /proc/cpuinfo  | grep "model name" | sort -u  | cut -d":" -f2`
fi

if [ "$OS" == "OpenBSD" ]; then 
   sysctl hw | grep hw.model | sort -u | cut -d"=" -f2 
fi


echo
echo "Memory"
echo "=========================================================================="
if [ "$OS" == "OpenBSD" ]; then
    top -d1 | sed '5q;d'
fi 

if [ "$OS" == "Linux" ]; then
    free -h | head -2
fi

echo
echo
echo "Disk usage" 
echo "================================================"
df -h


echo
echo "Network Information"
echo "================================================"

#code to find the default Gateway either on Linux or OpenBSD
if [ "$OS" == "Linux" ]; then
    echo -e "Gateway\t\t:" `sudo route -n | awk '/^0.0.0.0/{ printf $2"\n" } '`
fi

if [ "$OS" == "OpenBSD" ]; then
   echo -e "Gateway\t\t:" `sudo route -n  show | awk '/^default/{ printf $2"\n" } '`
fi

#echo "DNS" `nslookup ls | grep Server:`
echo -e "DNS Server(s)\t:"  `cat /etc/resolv.conf  | grep nameserver | cut -d" " -f2`

echo
echo "Network Listening Services (IPv4)"
echo "================================================================================================"
sudo netstat -a | grep "LISTEN"


echo
echo "Services"
echo "=========================="

if [ "$OS" == "OpenBSD" ]; then
     services=`rcctl ls on`
     for service in $services;
       do
          echo "[+] $service";

      done;
fi

if [ "$OS" == "Linux" ]; then
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
fi
