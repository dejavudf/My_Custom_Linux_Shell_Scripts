#!/bin/bash
# maker text box script (adaptive size)
# by dejavudf
# version 1.1 20241107
# debian/ubuntu/mint

#variables initial declaration
VAR_C_MAX_SIZE=24
VAR_R_MAX_SIZE=80
VAR_C_SIZE=0
VAR_R_SIZE=0
VAR_S=""
VAR_COUNT=3
VAR_VALIDATION=1
VAR_SPACE=" "
VAR_SPACE_SIZE=0
VAR_S_SIZE=0
VAR_R_SIZE2=0

#func choice box size
FUNC_BOX_SIZE() {
until [ "$VAR_VALIDATION" == 0 ]
do
	clear
	echo "####################################"
	echo "# Make my box script - by dejavudf #"
	echo "####################################"
	echo -n "Choose box column size (max/default $VAR_C_MAX_SIZE): "
	read -r VAR_C_SIZE
	if [ -z "$VAR_C_SIZE" ]
	then
		VAR_C_SIZE="$VAR_C_MAX_SIZE"
	fi
	echo -n "Choose box row size (max/default $VAR_R_MAX_SIZE): "
	read -r VAR_R_SIZE
	if [ -z "$VAR_R_SIZE" ]
        then
                VAR_R_SIZE="$VAR_R_MAX_SIZE"
        fi
	echo -n "Choose one character (default #): "
	read -r VAR_S
	        if [ -z "$VAR_S" ]
        then
                VAR_S="#"
        fi
	if [ -z "${VAR_C_SIZE//[0-9]}" ] && [ -z "${VAR_R_SIZE//[0-9]}" ]
	then
		VAR_R_SIZE2=$((VAR_R_SIZE -2))
		VAR_S_SIZE="${#VAR_S}"
		if [ "$VAR_C_SIZE" -gt "$VAR_C_MAX_SIZE" ] || [ "$VAR_R_SIZE" -gt "$VAR_R_MAX_SIZE" ] || [ ! "$VAR_S_SIZE" -eq 1  ]
		then
			echo "Invalid input. Please, try again."
			sleep 3
			VAR_VALIDATION=1
		else
			VAR_R=$(printf "%-${VAR_R_SIZE}s" "$VAR_S")
			VAR_SPACE_SIZE=$(printf "%-${VAR_R_SIZE2}s" "$VAR_SPACE")
			VAR_SPACE_SIZE=$(echo "${VAR_SPACE_SIZE// /$VAR_SPACE}")
			VAR_TEXT_SIZE="$((VAR_C_SIZE * VAR_R_SIZE))"
			VAR_VALIDATION=0
			FUNC_MAKE_BOX
		fi
	else
		echo "Invalid input. Please, try again."
		sleep 3
		VAR_VALIDATION=1
	fi
done
}

#func make box
FUNC_MAKE_BOX() {
clear
echo "Box Size: $VAR_R_SIZE (row) x $VAR_C_SIZE (col) = $VAR_TEXT_SIZE"
echo "${VAR_R// /$VAR_S}"
while [ "$VAR_COUNT" -le "$VAR_C_SIZE" ]
do
	echo "$VAR_S""$VAR_SPACE_SIZE""$VAR_S"
	VAR_COUNT=$((VAR_COUNT + 1))
done
echo "${VAR_R// /$VAR_S}"
exit 0
}

#script begin
FUNC_BOX_SIZE
