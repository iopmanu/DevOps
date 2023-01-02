 #!/bin/bash
#output
function output {
        echo "HOSTNAME = $HOSTNAME"
        echo "TIMEZONE =$TIMEZONE"
        echo "USER = $USER"
        echo "OS = $OS"
	echo "DATE = $DATE"
	echo "UPTIME =$UPTIME"
	echo "UPTIME_SEC = $UPTIME_SEC"
	echo "IP = $IP"
	echo "MASK = $MASK"
	echo "GATEWAY = $GATEWAY"
	echo "RAM_TOTAL = $RAM_TOTAL"
	echo "RAM_USED = $RAM_USED"
	echo "RAM_FREE = $RAM_FREE"
	echo "SPACE_ROOT = $SPACE_ROOT"
	echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
	echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
}

#saving
function save {
	read -p "Do you want to save previous information? (Y/N): " status
	result=0

	if [ "$status" = "Y" ] || [ "$status" = "y" ]
	then
		result=1
	fi

	return $result
}

#main program

 HOSTNAME=$(hostname)
 TIMEZONE=$(timedatectl | grep zone | sed 's|.*:||')
 USER=$(whoami)
 OS=$(cat /etc/issue | awk '{print $1,$2}' | tr -s '\n\r' ' ')
 DATE=$(date  +"%d %B %Y %T")
 UPTIME=$(uptime -p | sed 's|.*p||')
 UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
 IP=$(ip addr show | grep "inet " | grep "dynamic" | awk '{print $2}' | sed 's/\/../ /')
 MASK=$(netstat -rn | tail +5 | awk '{print $3}')
 GATEWAY=$(netstat -rn | tail +5 | awk '{print $2}')
 RAM_TOTAL=$(free -m | tail +2 | grep Mem: | awk '{printf "%.3f GB", $2/1024}')
 RAM_USED=$(free -m | tail +2 | grep Mem: | awk '{printf "%.3f GB", $3/1024}')
 RAM_FREE=$(free -m | tail +2 | grep Mem: | awk '{printf "%.3f GB", $4/1024}')
 SPACE_ROOT=$(df -m | grep /dev/nvme0n1p7 |awk '{printf "%d MB ", $2}')
 SPACE_ROOT_USED=$(df -m | grep /dev/nvme0n1p7 |awk '{printf "%.2f MB ", $3}')
 SPACE_ROOT_FREE=$(df -m | grep /dev/nvme0n1p7 |awk '{printf "%.2f MB ", $4}')
 output
 save

 if [[ $? -eq 1 ]]
 then
	 current_date=$(date +"%d_%m_%y_%H_%M_%S")
	 filename="$current_date.status"
	 output >> $filename
 fi
 
