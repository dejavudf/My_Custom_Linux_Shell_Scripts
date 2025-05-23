#!/bin/bash
# script to remove encapsulation underlay like VXLAN, GENEVE and others (first x bytes) inside pcap file
# by dejavudf
# version 1.0 31/10/2024
# tested and validated on debian/ubuntu/mint

#change colours - theme: Flamengo T-Shirt #3 2024
export NEWT_COLORS='
	root=,gray
	entry=,gray
	roottext=gray,black
'

#variables - whiptail usage
VAR_BT_E="Enter"
VAR_BT_Q="Quit"
VAR_BT_C="Continue"
VAR_T="Script to Remove First X Bytes from PCAP File"
VAR_BKT="mymail@mailserver.com - https//github.com/dejavudf/"
VAR_MB_IE="Input error. Please, try again!"
VAR_MB_NI="editcap not installed! Try: apt-cache search editcap"
VAR_MB_WC="Wellcome! Use this script to remove layers like VXLAN, GENEVE, MAC-in-MAC, QinQ... "
VAR_MB_ECE="editcap error!"

#func invalid input
FUNC_INVALID_INPUT() {
	clear
	whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "$VAR_MB_IE" --ok-button "$VAR_BT_C" 0 0
}

#func remove bytes
FUNC_REMOVE_BYTES() {
until [ "$VAR_BYTES_VALIDATION" -eq 0 ]
do
	VAR_BYTES=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "First Bytes to Remove -> Number (1 to 128)" --inputbox 'Bytes to Remove:' 0 0 3>&2 2>&1 1>&3)
 	if [ $? == 1 ]
        then
                exit
        elif [ $? == 255 ]
        then
                VAR_BYTES_VALIDATION=1
	else
		if [[ "$VAR_BYTES" =~ ^[0-9]+$ ]]
		then
			if [[ "$VAR_BYTES" -le 128 ]] || [[ "$VAR_BYTES" -eq 0 ]]
			then
				VAR_BYTES_VALIDATION=0;
			else
				VAR_BYTES_VALIDATION=1;
			fi
        	else
			VAR_BYTES_VALIDATION=1
		fi
	fi
done
}

#func Source File
FUNC_SOURCE_FILE() {
VAR_SOURCE_FILE=""
VAR_SOURCE_FILE_VALIDATION=1
until [ "$VAR_SOURCE_FILE_VALIDATION" == 0 ]
do
        clear
        VAR_SOURCE_FILE=$(whiptail --clear --ok-button "$VAR_BT_E" --cancel-button "$VAR_BT_Q" --title "$VAR_T" --backtitle "Source PCAP File -> File Name and Path" --inputbox 'Source PCAP File:' 0 0 3>&2 2>&1 1>&3)
        if [ $? == 1 ]
        then
               	exit
        elif [ $? == 255 ]
        then
              	VAR_SOURCE_FILE_VALIDATION=1
                continue
        else
                if [ -r "$VAR_SOURCE_FILE" ]
                then
                       	VAR_SOURCE_FILE_VALIDATION=0
                else
                       	FUNC_INVALID_INPUT
                       	VAR_SOURCE_FILE_VALIDATION=1
		fi
	fi
done
}

# script begin
#check if editcap is installed before proceed
if editcap > /dev/null
then
	whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "$VAR_MB_NI" --ok-button "$VAR_BT_Q" 0 0
        exit 1
else
	whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "$VAR_MB_WC" --ok-button "$VAR_BT_C" 0 0
	FUNC_SOURCE_FILE
	FUNC_REMOVE_BYTES
	VAR_DESTINATION_FILE="${VAR_SOURCE_FILE%.pcap}_new.pcap"
	clear
	if editcap -C "$VAR_BYTES" -L ./"$VAR_SOURCE_FILE" ./"$VAR_DESTINATION_FILE"
	then
		whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "First $VAR_BYTES bytes removed. New File: $VAR_DESTINATION_FILE" --ok-button "$VAR_BT_Q" 0 0
		exit 0
	else
		whiptail --clear --title "$VAR_T" --backtitle "$VAR_BKT" --msgbox "$VAR_MB_ECE" --ok-button "$VAR_BT_Q" 0 0
		FUNC_SOURCE_FILE
	fi
fi
exit 1
