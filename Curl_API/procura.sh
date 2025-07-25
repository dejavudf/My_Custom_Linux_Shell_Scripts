#!/bin/bash
# Search text inside files list (tree ./*) and show file by Alexsandro Farias (dejavudf@gmail.com)
# version 2.0 - built 20200916
# Ubuntu/Debian

VAR_TEXT=""
VAR_TEXT_VALIDATION=1
VAR_FILE=""

#get text to search/find and show result
until [ $VAR_TEXT_VALIDATION == 0 ]
do
	clear
	VAR_TEXT=$(whiptail --clear --cancel-button "Sair" --title "Find text inside files on tree ./" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --inputbox "Search/Find inside file(s):" 0 0 3>&2 2>&1 1>&3)
	if [ $? == 1 ]
	then
		exit
	elif [ -z $VAR_TEXT ]
	then
		VAR_TEXT_VALIDATION=1
	elif [ ! "${#VAR_TEXT}" -ge 3 ]
	then
		VAR_TEXT_VALIDATION=1
	else
		find ./ -type f | grep -i ".sh" | while read VAR_FILE
		do
			if cat $VAR_FILE | grep -iI "$VAR_TEXT"
			then
				clear
				whiptail --clear --scrolltext --title "Text: $VAR_TEXT | File: $VAR_FILE | Press ESC to view next file" --textbox $VAR_FILE --ok-button "Quit" 0 0
				if [ $? == 255 ]
				then
					continue
				else
					break
				fi
			else
				continue
			fi
		done
	fi
done
rm -f ./tmp.tmp
clear
exit 0
