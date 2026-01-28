#!/bin/bash

VAR_INPUT_MASK="$1"
VAR_COUNT=1
VAR_OCTA=1
VAR_BIT=1

if [ "$VAR_INPUT_MASK" == "0" ]
then
	VAR_NET_OCT1="0"
	VAR_NET_OCT2="0"
	VAR_NET_OCT3="0"
	VAR_NET_OCT4="0"
else
	while [ "$VAR_COUNT" -le "$VAR_INPUT_MASK" ]
	do
	if [ "$VAR_OCTA" == "1" ]
	then
		VAR_NET_OCT1=$((VAR_NET_OCT1+128/VAR_BIT))
		VAR_BIT=$((VAR_BIT*2))
		if [ "$VAR_COUNT" == "9" ]
		then
			VAR_NET_OCT1=$((VAR_NET_OCT1+128/VAR_BIT))
			VAR_OCTA=2
			VAR_BIT=1
		fi
	elif [ "$VAR_OCTA" == "2" ]
	then
		VAR_NET_OCT2=$((VAR_NET_OCT2+128/VAR_BIT))
		VAR_BIT=$((VAR_BIT*2))
		if [ "$VAR_COUNT" == "17" ]
		then
			VAR_NET_OCT2=$((VAR_NET_OCT2+128/VAR_BIT))
			VAR_OCTA=3
			VAR_BIT=1
		fi
	elif [ "$VAR_OCTA" == "3" ]
	then
		VAR_NET_OCT3=$((VAR_NET_OCT3+128/VAR_BIT))
		VAR_BIT=$((VAR_BIT*2))
		if [ "$VAR_COUNT" == "25" ]
		then
			VAR_NET_OCT3=$((VAR_NET_OCT3+128/VAR_BIT))
			VAR_OCTA=4
			VAR_BIT=1	
		fi
	elif [ "$VAR_OCTA" == "4" ]
	then
		VAR_NET_OCT4=$((VAR_NET_OCT4+128/VAR_BIT))
		VAR_BIT=$((VAR_BIT*2))
	fi
	VAR_COUNT=$((VAR_COUNT+1))
	done 
fi
echo "$VAR_NET_OCT1"".""$VAR_NET_OCT2"".""$VAR_NET_OCT3"".""$VAR_NET_OCT4"
