#!/bin/bash

clear
echo "Logged in user:" $USER

echo
echo -n "Distribution and kernel version:"
cat /etc/issue | cut -c1-13
echo -n "uname results: "
uname -a


echo
echo "Shellsock Bug Vulnerability"
env x='() { :;}; echo vulnerable' bash -c `echo hello`


echo
echo "Mounted filesystems"
mount -l


echo
echo "Network Configuration"
ifconfig -a | grep 'Link\|inet'

echo
echo "Print Hosts"
cat /etc/hosts

echo echo "Print ARP"
arp

echo
echo "Development tools availability"
which gcc
which g++
which python


echo "Print TCP/UDP Listening Services"
netstat -tunlpe

echo
echo "Installed Packages"
dpkg -l


echo
echo "Find Readable Folders in /etc"
find /etc -user `id -u` -perm -u=r -o -group `id -g` -perm -g=r -o -perm -o=r -ls 2> /dev/null


echo
echo "Find SUID and GUID files"
find / -type f -perm -u=s -o -type f -perm -g=s -ls  2> /dev/null

echo 
echo "Find all SUID root files"
find / -user root -perm -4000 -print 2> /dev/null
