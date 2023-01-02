#!/bin/bash

. ./colours.conf

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

# Для вывода цветовой схемы после информации о системе
function print_colour {
	colour_assigment $1
	colour="\033[4$?m"
	default="\033[37m\033[0m"

	case "$1" in
		1) echo -e " ${colour}(white)${default}";;
		2) echo -e " ${colour}(red)${default}";;
		3) echo -e " ${colour}(green)${default}";;
		4) echo -e " ${colour}(blue)${default}";;
		5) echo -e " ${colour}(purple)${default}";;
		6) echo -e " ${colour}(black)${default}";;
	esac
}

function print_colour_info {
	echo -en "\nColumn 1 background = $1"
	print_colour $1
	echo -en "Column 1 font color = $2"
        print_colour $2
	echo -en "Column 2 background = $3"
        print_colour $3
	echo -en "Column 2 font color = $4"
	print_colour $4
}

# Получение информации о системе
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

# Цвета по умолчанию и обработка цветов получение из .conf файла.
default_left_background_colour="\033[40m"
default_left_font_colour="\033[37m"
default_right_background_colour="\033[41m"
default_right_font_colour="\033[36m"

colour_assigment $column1_background
left_background_colour="\033[4$?m"
colour_assigment $column1_font_color
left_font_colour="\033[3$?m"
colour_assigment $column2_background
right_background_colour="\033[4$?m"
colour_assigment $column2_font_color
right_font_colour="\033[3$?m"

possible_colours="^[1-6]$"
if [[ $column1_background =~ $possible_colours && $column1_font_color =~ $possible_colours && $column2_background =~ $possible_colours && $column2_font_color =~ $possible_colours ]]; then
	if [[ $column1_background -ne $column1_font_color && $column2_background -ne $column2_font_color ]]; then
		output $left_background_colour $left_font_colour $right_background_colour $right_font_colour
		print_colour_info $column1_background $column1_font_color $column2_background $column2_font_color
		exit
	fi
fi

if [[ -z $column1_background || $column1_background -eq $column1_font_color ]]; then
	left_background_colour=$default_left_background_colour
	column1_background=6
fi
if [[ -z $column1_font_color ]]; then
	left_font_colour=$default_left_font_colour
	column1_font_color=1
fi
if [[ -z $column2_background || $column2_background -eq $column2_font_color ]]; then
	right_background_colour=$default_right_background_colour
	column2_background=2
fi
if [[ -z $column2_font_color ]]; then
	right_font_colour=$default_right_font_colour
	column2_font_color=4
fi
output $left_background_colour $left_font_colour $right_background_colour $right_font_colour
print_colour_info $column1_background $column1_font_color $column2_background $column2_font_color
