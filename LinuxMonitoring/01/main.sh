#/bin/bash

text=$1

# Используем сравнение с регулярным выражением с помощью оператора =~

if [[ $text =~ ^[0-9]+$ ]]; then
	echo "Incorrect input"
else
	echo $text
fi
