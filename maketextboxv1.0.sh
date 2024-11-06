#!/bin/bash
# maker text box script (adaptive size)
# by dejavudf
# version 1.0 20241106
# debian/ubuntu/mint

#variables
VAR_C_SIZE=0
VAR_R_SIZE=0
VAR_S=#
VAR_COUNT=3
VAR_VALIDATION=1
VAR_SPACE=" "
VAR_SPACE_SIZE=0
VAR_S_SIZE=0
VAR_R_SIZE2=0

#choice box size
until [ "$VAR_VALIDATION" == 0 ]
do
	echo "####################################"
	echo "# Make my box script - by dejavudf #"
	echo "####################################"
	echo "Choose box column size:"
	read -r VAR_C_SIZE
	echo "Choose box row size:"
	read -r VAR_R_SIZE
	echo "Choose charactere:"
	read -r VAR_S
	VAR_R_SIZE2=$((VAR_R_SIZE -2))
	VAR_S_SIZE="${#VAR_S}"
	if [ "$VAR_C_SIZE" -ge 21 ] || [ "$VAR_R_SIZE" -ge 61 ] || [ ! "$VAR_S_SIZE" -eq 1  ]
	then
		echo "Invalid input. Please, try again."
		sleep 3
		VAR_VALIDATION=1
	else
		VAR_VALIDATION=0
	fi
done

#more variables
VAR_R=$(printf "%-${VAR_R_SIZE}s" "$VAR_S")
VAR_SPACE_SIZE=$(printf "%-${VAR_R_SIZE2}s" "$VAR_SPACE")
VAR_SPACE_SIZE=$(echo "${VAR_SPACE_SIZE// /$VAR_SPACE}")

#make box
clear
echo "Box Size: $VAR_R_SIZE (row) x $VAR_C_SIZE (col):"
echo "${VAR_R// /$VAR_S}"
while [ "$VAR_COUNT" -le "$VAR_C_SIZE" ]
do
	echo "#""$VAR_SPACE_SIZE""#"
	VAR_COUNT=$((VAR_COUNT + 1))
done
echo "${VAR_R// /$VAR_S}"
exit 0

