#!/bin/bash
# by dejavudf
# version 1.0 - built 20241011
# Ubuntu/Debian
# Variables = No validation
# this scripts just helps to learn how to use whiptail command
# 0 0 = mean auto sized boxes

#initial screen
clear
whiptail --clear --title "MyMenu Script" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --msgbox "Welcome to MyMenu Tool with whiptail Command" --ok-button "Continue" 0 0

#continue screen
clear
VAR_CONTINUE=$(whiptail --clear --title "Continue?" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --yesno "$1" 0 0 3>&2 2>&1 1>&3)
if [ $? == 1 ]
then
        clear;
        exit
fi

#menu screen
clear
VAR_ALGORITHM=$(whiptail --clear --title "Select Hash Algorithm Menu" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --menu "Choose Hash Algorithm:" 0 0 3 "1" "MD5" "2" "SHA" "3" "QUIT" 3>&2 2>&1 1>&3)
if [ $VAR_ALGORITHM == 3 ]
then
	clear;
	exit
fi

#file(s) selection screen
clear
VAR_FILE=$(whiptail --clear --title "Select File(s) Menu" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --inputbox "File Name or Mask:" 0 0 3>&2 2>&1 1>&3)

#Calc hash
if [ $VAR_ALGORITHM == 1 ]
then
	VAR_RESULT=$(md5sum $VAR_FILE)
	VAR_ALGORITHM=MD5
else
	VAR_RESULT=$(shasum $VAR_FILE)
	VAR_ALGORITHM=SHA
fi

#info box with result screen
clear
whiptail --clear --title "File Hash with $VAR_ALGORITHM Result" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --msgbox "File Hash: $VAR_RESULT" --ok-button "bye" 0 0

#give me your password box
clear
whiptail --clear --title "Now, pay your duties and give me your password:" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --passwordbox "Password" 0 0

#sell password
clear
for i in {1..100}
do
	sleep 0.01
	export TERM=linux
	echo $i | whiptail --title "Now, pay your duties and give me your password:" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --gauge "Selling your password. Wait..." 0 0 $i
done

#thanks menu
clear
whiptail --title "Thanks, password sold!" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --infobox "Thanks, password sold" 0 0
sleep 2

#hobbies checklist
clear
VAR_HOBBIES=$(whiptail --separate-output --checklist "Hobbies?" 0 0 4 "Music" "Play, listen, watch..." OFF "Linux" "Use, programmer..." OFF "Network" "Ping, traceroute..." OFF "Shell" "No way..." OFF 3>&2 2>&1 1>&3)
for VAR_HOBBIE in $VAR_HOBBIES
do
	clear
	if [ "$VAR_HOBBIE" == "Music" ]
	then
		whiptail --title "You like music!" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --infobox "" 0 0
	elif [ "$VAR_HOBBIE" == "Linux" ]
	then
		whiptail --title "You like linux!" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --infobox "" 0 0
	elif [ "$VAR_HOBBIE" == "Network" ]
	then
		whiptail --title "You like computer networks!" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --infobox "" 0 0
	elif [ "$VAR_HOBBIE" == "Shell" ]
	then
		whiptail --title "You dont like shell. Argh!" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --infobox "" 0 0
	else
		whiptail --title "You dont like nothing. Stupid" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --infobox "" 0 0
	fi
	sleep 2
done

#your age radio box
clear
VAR_AGE=$(whiptail --separate-output --radiolist "Your age?" 0 0 2 "18 or less" "Very Young" OFF "19 or more" "Very Old" ON 3>&2 2>&1 1>&3)
if [ "$VAR_AGE" == "18 or less" ]
then
	whiptail --title "Time to learn something, kid!" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --textbox $0 0 0
else
	whiptail --title "Time check this script again, elder!" --backtitle "dejavudf@gmail.com - https://github.com/dejavudf/" --textbox $0 0 0
fi
exit
