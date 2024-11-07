#!/bin/bash
# whiptail with automenuoptions by dejavudf
# version 1.0 20241107
# debian/ubuntu/mint

#change colours - theme: Flamengo T-Shirt #3 2024
export NEWT_COLORS='
	root=,gray
	entry=,gray
	roottext=gray,black
'

#variables
VAR_COUNT=1

#func auto menu
FUNC_AUTO_MENU() {
clear
VAR_CHOICE=$(whiptail --menu "Choose:" 0 0 ${VAR_OPTIONS[*]} 3>&2 2>&1 1>&3)
VAR_FILE_NAME=$((VAR_CHOICE * 2))
whiptail --title "File name: ${VAR_OPTIONS[$VAR_FILE_NAME]}" --textbox ./${VAR_OPTIONS[$VAR_FILE_NAME]} 0 0
unset VAR_OPTIONS
VAR_COUNT=1
FUNC_MENU_FILE
exit
}

#choose file extension (file options)
FUNC_MENU_FILE() {
clear
VAR_FILE_TYPE=$(whiptail --inputbox "File name or files extension (example: *.sh):" 0 0 3>&2 2>&1 1>&3)
if [ $? == 1 ]
then
	exit 0
elif [ -z "$VAR_FILE_TYPE" ] || [ $? == 255 ]
then
	FUNC_MENU_FILE
else
	VAR_TOTAL_OPTIONS=$(ls $VAR_FILE_TYPE | wc | awk '{print $1}')
	if [ "$VAR_TOTAL_OPTIONS" == 0 ]
	then
		clear
                whiptail --msgbox "Invalid file extension filter or file not found." 0 0
                FUNC_MENU_FILE
	else
		VAR_OPTIONS+=("$VAR_TOTAL_OPTIONS")
 		for VAR_FILE in $VAR_FILE_TYPE
		do
			VAR_OPTIONS+=("$VAR_COUNT")
			VAR_OPTIONS+=("$VAR_FILE")
			VAR_COUNT=$((VAR_COUNT + 1 ))
			echo "${VAR_OPTIONS[*]}"
		done
		FUNC_AUTO_MENU
	fi
fi
}

#script begin
FUNC_MENU_FILE
