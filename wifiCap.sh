#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo "Please run as root! Exiting..."
    exit 1
fi


wlaninterface=wlan0
m=mon

i=$wlaninterface$m

currDate=$(date +%m_%d_%Y)

recon=/captures/scouted_$currDate
pcapfile=/captures/capFile_$currDate

recontime=120s

capturetime=3600s

#rm $recon*.csv &> /dev/inull
#rm $pcapfile*.cap &> /dev/null

airmon-ng check kill &
airmon-ng start $wlaninterface$m &

airodump-ng --encrypt OPN --output-format csv -w $recon $i &> /dev/null &

sleep $recontime

#kill the most recent background command
kill $!

#extract channel
ch=$(grep -a 'OPN' $recon*.csv | head -1 | cut -d',' -f4)

airodump-ng --encrypt OPN --output-format pcap --channel $ch -w pcapfile $i &> /dev/null &

sleep $capturetime

kill $!

shutdown -P now
