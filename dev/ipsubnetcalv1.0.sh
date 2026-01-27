#!/bin/bash
# by dejavudf - https://github.com/dejavudf
# version 1.0 - IPv4 network/subnet calculator - Classes A, B and C only
# debian/ubuntu/mint

#variables
VAR_INVALID_INPUT="Invalid network input. Please, try again"

#function ip net calculator
FUNC_IP_NET_CALCULATOR(){
# Calculate Network Address
VAR_RESULT_OCT1=$((VAR_MASK_OCT1 & VAR_NET_OCT1))
VAR_RESULT_OCT2=$((VAR_MASK_OCT2 & VAR_NET_OCT2))
VAR_RESULT_OCT3=$((VAR_MASK_OCT3 & VAR_NET_OCT3))
VAR_RESULT_OCT4=$((VAR_MASK_OCT4 & VAR_NET_OCT4))
echo "Network:   $n1.$n2.$n3.$n4"
echo "CIDR:"
# Calculate Broadcast Address (Network address OR inverted mask)
# Inverted mask for a byte is 255 - mask_byte
VAR_BROADCAST1=$((VAR_RESULT_OCT1 | (255 - VAR_NET_OCT1)))
VAR_BROADCAST2=$((VAR_RESULT_OCT2 | (255 - VAR_NET_OCT2)))
VAR_BROADCAST3=$((VAR_RESULT_OCT3 | (255 - VAR_NET_OCT3)))
VAR_BROADCAST4=$((VAR_RESULT_OCT4 | (255 - VAR_NET_OCT4)))
echo "Broadcast Address: $VAR_BROADCAST1.$VAR_BROADCAST2.$VAR_BROADCAST3.$VAR_BROADCAST4"
# Calculate First and Last Usable IPs
echo "First Valid IP Address:  $VAR_RESULT_OCT1.$VAR_RESULT_OCT2.$VAR_RESULT_OCT3.$((n4 + 1))"
echo "Last Valid IIP Address:   $b1.$b2.$b3.$((b4 - 1))"
}


#function mask wild validation
FUNC_VALIDATE_WILD(){
if [ "$1" == "0" ] || [ "$1" == "128" ] || [ "$1" == "192" ] || [ "$1" == "224" ] || [ "$1" == "240" ] || [ "$1" == "248" ] \
   || [ "$1" == "252" ] || [ "$1" == "254" ] || [ "$1" == "255" ]
then
    continue
else
    FUNC_INPUT_MENU
fi
}

#function mask WILD validation
FUNC_INPUT_VALIDATION_MASK_WILD(){
IFS=. read -r VAR_MASK_OCT1 VAR_MASK_OCT2 VAR_MASK_OCT3 VAR_MASK_OCT4 <<< "$VAR_INPUT_MASK"
FUNC_VALIDATE_WILD $VAR_MASK_OCT1
FUNC_VALIDATE_WILD $VAR_MASK_OCT2
FUNC_VALIDATE_WILD $VAR_MASK_OCT3
FUNC_VALIDATE_WILD $VAR_MASK_OCT4
FUNC_IP_NET_CALCULATOR_WILD
}

#function check and validate cidr
FUNC_INPUT_DETECT_MASK(){
VAR_INPUT_MASK=$(echo $VAR_INPUT | awk -F"/" '{print $2}')
if [[ "$VAR_INPUT_MASK" =~ ^[0-9]+$ ]] && [ "$VAR_INPUT_MASK" -lt 33 ]
then
    FUNC_IP_NET_CALCULATOR_CIDR;
else
    FUNC_INPUT_VALIDATION_MASK_WILD
fi

}

#function net validation
FUNC_INPUT_VALIDATION_NET(){
VAR_INPUT_NET=$(echo $VAR_INPUT | awk -F"/" '{print $1}')
if [[ "$VAR_INPUT_NET" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
then
    if [ "$(echo "$VAR_INPUT_NET" | cut -d. -f1)" -gt 255 ]
    then
        echo $VAR_INVALID_INPUT;
        sleep 2
        FUNC_INPUT_MENU
    fi
    if [ "$(echo "$VAR_INPUT_NET" | cut -d. -f2)" -gt 255 ]
    then
        echo $VAR_INVALID_INPUT;
        sleep 2
        FUNC_INPUT_MENU
    fi
    if [ "$(echo "$VAR_INPUT_NET" | cut -d. -f3)" -gt 255 ]
    then
        echo $VAR_INVALID_INPUT;
        sleep 2
        FUNC_INPUT_MENU
    fi
    if [ "$(echo "$VAR_INPUT_NET" | cut -d. -f4)" -gt 255 ]
    then
        echo $VAR_INVALID_INPUT;
        sleep 2
        FUNC_INPUT_MENU
    else
        IFS=. read -r VAR_NET_OCT1 VAR_NET_OCT2 VAR_NET_OCT4 VAR_NET_OCT4 <<< "$VAR_INPUT_NET"
        FUNC_INPUT_DETECT_MASK
    fi
else
    echo $VAR_INVALID_INPUT;
    sleep 2
    FUNC_INPUT_MENU
fi
}

#func input menu
FUNC_INPUT_MENU(){
clear
echo " __________________________________________"
echo "|                                          |"
echo "|  Network Subnet Calculator by dejavudf   |"
echo "|__________________________________________|"
echo ""
echo -n "Type Network/Mask or Network/CIDR: "
read -r VAR_INPUT
FUNC_INPUT_VALIDATION_NET
}

#function menu - script starter
FUNC_INPUT_MENU





