#!/bin/bash
# by dejavudf - github.com/dejavudf
# version 1.0 14/06/2026
# debian/ubuntu/mint
# find and check/remove duplicated files inside a directory tree (folder and subfolders)

#variables declarations
VAR_MODE=0
VAR_ARRAY_SIZE=()
VAR_ARRAY_HASH=()
VAR_FILE=""
VAR_HASH=""
VAR_DELETE=""

#function mode (check or remove)
FUNC_MODE() {
if [ "$VAR_MODE" == "0" ]
then
	clear
	echo "Duplicated files list:"
	if [ -f ./duplicate.tmp ]
	then
		cat ./duplicate.tmp
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

#function hash (calc file md5 hash)
FUNC_HASH() {
while read -r VAR_FILE
do
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
done < find "$VAR_DIR" -type f
FUNC_MODE
}

#function size (check files with same size)
FUNC_SIZE() {
while read -r VAR_FILE
do
	VAR_SIZE=$(stat -c %S "$VAR_FILE")
	if ! echo "${ARRAY_SIZE[@]}" | grep -w "$VAR_SIZE"
	then
		ARRAY_SIZE+=("$VAR_SIZE")
	else
		ARRAY_HASH+=("$VAR_FILE")
	fi
done < find "$VAR_DIR" -type f
FUNC_HASH
}

#script begin - check parameters before run script
if [ "$1" == "-check" ] && [ -d "$2" ]
then
	VAR_MODE=0
	VAR_DIR="$2"
	FUNC_SIZE
elif [ "$1" == "-remove" ] && [ -d "$2" ]
then
	VAR_MODE=1
	VAR_DIR="$2"
	FUNC_SIZE
else
	clear
	echo "Error: Invalid Options!"
	echo "Usage: ./script_name Option1 (mode) Option2 (dir)"
	echo "Example: ./script_name { -check | -remove } { dir }"
	exit 1
fi
exit 0
