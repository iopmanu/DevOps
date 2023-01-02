 #!/bin/bash
# Функция вывода
function output {
	default="\033[37m\033[0m"

        echo -e "${1}${2}HOSTNAME${default} = ${3}${4}$HOSTNAME${default}"
        echo -e "${1}${2}TIMEZONE${default} =${3}${4}$TIMEZONE${default}"
        echo -e "${1}${2}USER${default} = ${3}${4}$USER${default}"
        echo -e "${1}${2}OS${default} = ${3}${4}$OS${default}"
	echo -e "${1}${2}DATE${default} = ${3}${4}$DATE${default}"
	echo -e "${1}${2}UPTIME${default} =${3}${4}$UPTIME${default}"
	echo -e "${1}${2}UPTIME_SEC${default} = ${3}${4}$UPTIME_SEC${default}"
	echo -e "${1}${2}IP${default} = ${3}${4}$IP${default}"
	echo -e "${1}${2}MASK${default} = ${3}${4}$MASK${default}"
	echo -e "${1}${2}GATEWAY${default} = ${3}${4}$GATEWAY${default}"
	echo -e "${1}${2}RAM_TOTAL${default} = ${3}${4}$RAM_TOTAL${default}"
	echo -e "${1}${2}RAM_USED${default} = ${3}${4}$RAM_USED${default}"
	echo -e "${1}${2}RAM_FREE${default} = ${3}${4}$RAM_FREE${default}"
	echo -e "${1}${2}SPACE_ROOT${default} = ${3}${4}$SPACE_ROOT${default}"
	echo -e "${1}${2}SPACE_ROOT_USED${default} = ${3}${4}$SPACE_ROOT_USED${default}"
	echo -e "${1}${2}SPACE_ROOT_FREE${default} = ${3}${4}$SPACE_ROOT_FREE${default}"
}

# Функция, определяющая цвет по нумерации в тз
function colour_assigment {
	result=0 		#default
	
	case "$1" in
		1) result=7;;		#white
		2) result=1;;		#red
		3) result=2;;		#green
		4) result=6;;		#blue
		5) result=5;;		#purple
		6) result=0;;		#black
	esac

	return $result
}

# С помощью -z проверяем, что строка пуста, с помощью -n, что не пуста
if [[ -n $5 ]]
then
	echo "Too much arguments."
	exit
elif [[ -n $4 ]]
then
	possible_colours="^[1-6]$"
	if [[ $1 =~ $possible_colours && $2 =~ $possible_colours && $3 =~ $possible_colours && $4 =~ $possible_colours ]]
	then
		if [[ $1 -ne $2 && $3 -ne $4 ]]
		then
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
			
			colour_assigment $1
			left_background_colour="\033[4$?m"
			colour_assigment $2
                       	left_font_colour="\033[3$?m"
			colour_assigment $3
                        right_background_colour="\033[4$?m"
			colour_assigment $4
                        right_font_colour="\033[3$?m"

			output $left_background_colour $left_font_colour $right_background_colour $right_font_colour
		else
			echo "Font colour shoud be different from background colour."
			exit
		fi
	else
		echo "Impossible colour. Possible range is from 1 to 6."
		exit
	fi
else
	echo "Not enough parametrs."
	exit
fi
