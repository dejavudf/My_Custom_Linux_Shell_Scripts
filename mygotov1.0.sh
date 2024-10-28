#!/bin/bash
# mygoto style menus - by dejavudf
# variables not validates
# version: 1.0 build 28/10/2024

func_main_menu() {
clear
echo "#####################"
echo "# MyGoTo Style Menu #"
echo "#####################"
echo "1 - ping"
echo "2 - traceroute"
echo "3 - dig"
echo "4 - nslookup"
echo "5 - quit"
echo -n "Choose Option: "
read var_option
if [ $var_option == 1 ]
then
	func_ping
elif [ $var_option == 2 ]
then
	func_traceroute
elif [ $var_option == 3 ]
then
	func_dig
elif [ $var_option == 4 ]
then
	func_nslookup
elif [ $var_option == 5 ]
then
	exit
else
	:
fi
}

func_ping() {
clear
echo "#####################"
echo "# MyGoTo Style Menu #"
echo "#####################"
echo "1 - ping (ICMP)"
echo "2 - main menu"
echo -n "Choose Option: "
read var_option
if [ $var_option == 1 ]
then
        ping -c 3 192.168.0.1
	sleep 2
	func_ping
elif [ $var_option == 2 ]
then
        func_main_menu
else
        :
fi
}

func_traceroute() {
clear
echo "#####################"
echo "# MyGoTo Style Menu #"
echo "#####################"
echo "1 - traceroute"
echo "2 - main menu"
echo -n "Choose Option: "
read var_option
if [ $var_option == 1 ]
then
        traceroute 192.168.0.1
        sleep 5
	func_traceroute
elif [ $var_option == 2 ]
then
        func_main_menu
else
        :
fi
}

func_dig() {
clear
echo "#####################"
echo "# MyGoTo Style Menu #"
echo "#####################"
echo "1 - dig"
echo "2 - main menu"
echo -n "Choose Option: "
read var_option
if [ $var_option == 1 ]
then
        dig 192.168.0.1
        sleep 5
	func_dig
elif [ $var_option == 2 ]
then
        func_main_menu
else
        :
fi
}

func_nslookup() {
clear
echo "#####################"
echo "# MyGoTo Style Menu #"
echo "#####################"
echo "1 - nslooiup"
echo "2 - main menu"
echo -n "Choose Option: "
read var_option
if [ $var_option == 1 ]
then
        nslookup 192.168.0.1
        sleep 5
	func_ping
elif [ $var_option == 2 ]
then
        func_main_menu
else
        :
fi
}

func_main_menu
