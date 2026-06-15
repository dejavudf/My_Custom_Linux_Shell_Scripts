#!/bin/bash

#delete tmp files
rm ./unique.tmp > /dev/null 2>&1
rm ./duplicate.tmp > /dev/null 2>&1
rm ./delete.tmp > /dev/null 2>&1

#script begin
if ! [ -f ./unique.tmp ] && ! [ -f ./duplicate.tmp ] && ! [ -f ./delete.tmp ]
then

	#variables
	VAR_PARAMETER_MODE=""
	VAR_PARAMETER_DIR=""
	VAR_MODE=0

	#functions
	FUNC_MODE() {
	if [ "$VAR_MODE" == "0" ]
	then
		clear
		echo "Duplicated files list:"
		cat ./duplicate.tmp
	elif [ "$VAR_MODE" == "1" ]
	then
		for VAR_DELETE in $(cat ./duplicate.tmp)
		do
			if rm "$VAR_DELETE" > /dev/null 2>&1
			then
				clear
				echo "File $VAR_DELETE deleted successfuly"
				sleep 1
				clear
			else
				echo "VAR_DELETE" >> ./error.tmp
			fi
		done
		clear
		exit 0
	fi
	}

	FUNC_HASH() {
	for VAR_FILE in $(find "$VAR_DIR" -type f)
	do
		clear
		echo "Checking if file $VAR_FILE is duplicated. Please, wait!"
		sleep 1
		VAR_HASH=$(md5sum "$VAR_FILE" | awk '{print $1}')
		if ! cat ./unique.tmp | grep "$VAR_HASH" > /dev/null 2>&1
		then
			echo "$VAR_HASH" >> ./unique.tmp
		else
			echo "$VAR_FILE" >> ./duplicate.tmp
		fi
	done
	FUNC_MODE
	}

	#script beginner - check parameters
	if [ "$1" == "-check" ] && [ -d "$2" ]
	then
		VAR_MODE=0
		VAR_DIR="$2"
		FUNC_HASH
	elif [ "$1" == "-remove" ] && [ -d "$2" ]
	then
		VAR_MODE=1
		VAR_DIR="$2"
		FUNC_HASH
	else
		clear
		echo "Error: Invalid Options!"
		echo "Usage: ./script_name Option1 (mode) Option2 (dir)"
		echo "Example: ./script_name { -check | -remove } { dir }"
	fi
else
	clear
	echo "Something is wrong deleting tmp files. Please, check your permissions."
fi
rm ./unique.tmp > /dev/null 2>&1
rm ./duplicate.tmp > /dev/null 2>&1
rm ./delete.tmp > /dev/null 2>&1
exit 0
