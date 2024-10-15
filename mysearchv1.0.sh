#!/bin/bash
# Mysearch script by dejavudf
# Search/find text inside text files
# version 1.0 - built 20241012
# Ubuntu/Debian

VAR_TEXT=""
VAR_TEXT_VALIDATION=1

#get text to search/find and show result
until [ $VAR_TEXT_VALIDATION == 0 ]
do
	clear
	VAR_TEXT=$(whiptail --clear --title "Select Text to Search/Find" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --inputbox "Search/Find inside file(s):" 0 0 3>&2 2>&1 1>&3)
	if [ $? == 1 ]
	then
		exit
	elif [ -z $VAR_TEXT ]
	then
		VAR_TEXT_VALIDATION=1
	else
		#if you want cut some characters just change cut number from -9999 to -40/-80 or somenthing like thisx
		echo "Searching Text. Wait...Please, be patient"
		find ./* -type f -exec grep -HinI "$VAR_TEXT" {} \; | grep -iv "binary" | cut -c -9999 | sed 's/$/ <-END_OF_LINE/' > ./tmp.tmp 3>&2 2>&1
		clear
		whiptail --scrolltext --title "Search/Find Result for word: $VAR_TEXT" --backtitle "./File Path/File Name:Line Number:Line Text" --textbox tmp.tmp 0 0
		VAR_TEXT_VALIDATION=0
	fi
done
rm -f ./tmp.tmp
clear
exit
