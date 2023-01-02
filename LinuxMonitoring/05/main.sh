#!/bin/bash

#Вывод данных

function top_ten_files {
	echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
	for i in {1..10}
	do
		file_info=$(find $directory 2>/dev/null -type f -exec du -h {} + | sort -rh | head -10 | sed "${i}q;d")
		if [[ -n $file_info ]]; then
			echo -n "$i -"
			echo -n "$(echo $file_info | awk '{print $2",", $1}'), "
			echo "$(echo $file_info | grep -m 1 -o -E "\.[^/.]+$" | awk -F . '{print $2}')"
		fi
	done
}

function top_ten_executable {
	echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)  "
        for i in {1..10}
        do
                file_info=$(find $directory 2>/dev/null -type f -executable -exec du -h {} + | sort -rh | head -10 | sed "${i}q;d")
                if [[ -n $file_info ]]; then
                        echo -n "$i -"
			path=$(echo $file_info | awk '{print $2}')
                        echo -n "$(echo $file_info | awk '{print $2",", $1}'), "
			hash=$(md5sum $path | awk '{print $1}')
			echo "$hash"
                fi
        done
}

timer_start=$(date +%s)

# Валидация входных данных
if [[ -n $2 ]]; then
	echo "It should be only one parametr with dir path."
	exit
fi

if [[ -z $1 ]]; then
	echo "You need to pass a directory as a paramter."
	exit
fi

if [[ ! -d $1 ]]; then
	echo "Incorrect path to the directory."
	exit
fi

if [[ ${1: -1} != "/" ]]; then				# Способ вырезать строку из подстроки как ${ПАРАМЕТР:СДВИГ:ДЛИНА}
	echo "Dicrectory path should end with '/'"
	exit
fi

# Информация о переданном каталоге и время работы скрипта
directory=$1

# awk print NR для нумерации строк
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$(find $directory* -type d -exec du -ch {} + 2>/dev/null | grep -v total | sort -rh | head -5 | awk '{print NR, "-", $2"/, "$1}')"

# Используем 2>/dev/null, чтобы перенаправить вывод в пустоту
echo "Total number of files = $(ls -laR $directory 2>/dev/null | grep "^-" | wc | awk '{print $1}')"

echo "Number of:"
echo "Configuration files = $(ls -laR $directory 2>/dev/null | grep ".conf" | wc | awk '{print $1}')"
echo "Text files = $(ls -laR $directory 2>/dev/null | grep ".txt" | wc | awk '{print $1}')"
echo "Executable files = $(find $directory* 2>/dev/null -type f -executable | wc -l)"
echo "Log files = $(find $directory* 2>/dev/null -type f -iname "*.log" | wc -l)"
echo "Archieve files = $(find $directory* 2>/dev/null -iname "*.tar" -o -iname "*.zip" -o -iname "*.rar" | wc -l)"
echo "Symbolic links = $(find $directory* 2>/dev/null -type l | wc -l)"
top_ten_files
top_ten_executable

timer_end=$(date +%s)
time=$(( $timer_end - $timer_start ))

echo "Script execution time (in second) = $time"
