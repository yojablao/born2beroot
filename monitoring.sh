#!/bin/bash

used=$(df -BM --total | awk '/^total/ {printf"%d", $3}')
total=$(df -BG --total | awk '/^total/ {print $2}')
porso=$(df -BG --total | awk '/^total/ {print $5}')

wall "
	#Architecture: $(uname -a)
	#CPU physical: $(nproc)
	#vCPU: $(nproc --all)
	#Memory Usage: $(free --mega | awk '/^Mem:/{printf "%s/%sMB (%0.2f%%)\n",$3 ,$2,($3/$2)*100}')
	#Disk Usage: $used/$total ($porso)
	#CPU load: $(uptime | awk '{print $10}' | tr -d ',')%
	#Last boot: $(who -b | awk '{print $3,$4}')
	#LVM use: $( lsblk | grep -q "lvm"  & echo "yes" || echo "no")
	#Connections TCP : $(netstat -ant | grep ESTABLISHED | wc -l) ESTABLISHED
	#User log: $(who | awk '{print $1}' |uniq | wc -l)
	#Network: IP $(hostname -I) ($(ip link show | awk '/link\/ether/ {print $2}'))
	#Sudo : $(cat /var/log/sudo/sudo.log|grep COMMAND| wc -l) cmd

"
