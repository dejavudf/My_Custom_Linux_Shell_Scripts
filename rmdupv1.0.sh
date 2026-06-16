#!/bin/bash

#delete tmp files and avoid output stdin/errors
FUNC_CLEAR() {
if rm ./unique.tmp > /dev/null 2>&1 && rm ./duplicate.tmp > /dev/null 2>&1 && rm ./delete.tmp > /dev/null 2>&1
then
	:
fi
}

#validate tmp file delections
if ! [ -f ./unique.tmp ] && ! [ -f ./duplicate.tmp ] && ! [ -f ./delete.tmp ]
then

	#variables
	VAR_MODE=0

	#functions
	FUNC_MODE() {
	if [ "$VAR_MODE" == "0" ]
	then
		clear
		echo "Duplicated files list:"
		if [ -f ./duplicate.tmp ]
		then
			cat ./duplicate.tmp
			exit 0
		else
			echo "No duplicated files found!"
		fi
	elif [ "$VAR_MODE" == "1" ]
	then
		for VAR_DELETE in $(cat < ./duplicate.tmp)
		do
			if rm "$VAR_DELETE" > /dev/null 2>&1
			then
				clear
				echo "File $VAR_DELETE deleted successfuly"
				echo "$VAR_DELETE" >> ./success.log
			else
				echo "$VAR_DELETE" >> ./error.log
			fi
		done
		clear
		echo "Script completed. Please, check files:"
		echo "./success.log to check success"
		echo "./error.log to check errors"
		exit 0
	fi
	}

	FUNC_HASH() {
	find "$VAR_DIR" -type f | while read -r VAR_FILE; do
		clear
		echo "Checking if file $VAR_FILE is duplicated. Please, wait!"
		VAR_HASH=$(md5sum "$VAR_FILE" | awk '{print $1}')
		VAR_SIZE=$(stat -c %s "$VAR_FILE")
		if ! cat < ./unique.tmp | grep "$VAR_HASH$VAR_SIZE" > /dev/null 2>&1
		then
			echo "$VAR_HASH$VAR_SIZE" >> ./unique.tmp
		else
			echo "$VAR_FILE" >> ./duplicate.tmp
		fi
	done
	FUNC_MODE
	}

	#script begin - check parameters
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
FUNC_CLEAR
exit 0
