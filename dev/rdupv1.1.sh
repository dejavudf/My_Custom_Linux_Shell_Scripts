#!/bin/bash
# by dejavudf - github.com/dejavudf
# version 1.1 15/06/2026
# debian/ubuntu/mint
# find and check/remove duplicated files inside a directory tree (folder and subfolders)

#variables declarations
VAR_MODE=0
ARRAY_SIZE=()
ARRAY_HASH=()
ARRAY_DUP=()
ARRAY_FILE=()
VAR_FILE=""
VAR_HASH=""

#function mode (check or remove)
FUNC_MODE() {
if [ "$VAR_MODE" == "0" ]
then
	clear
	echo "Duplicated files list:"
	echo "${ARRAY_DUP[@]}"
	exit 0
elif [ "$VAR_MODE" == "1" ]
then
	for VAR_FILE in "${ARRAY_DUP[@]}"
	do
		clear
		echo "Deleting duplicated file $VAR_FILE. Please wait."
		if rm /y "$VAR_FILE"
		then
			echo "$VAR_FILE" >> ./success.log
		else
			echo "$VAR_FILE" >> ./error.log
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
for VAR_FILE in "${ARRAY_FILE[@]}"
do
	clear
	echo "Hashing file $VAR_FILE using MD5. Please wait."
	VAR_HASH=$(md5sum "$VAR_FILE" | awk '{print $1}')
	if ! echo "${ARRAY_HASH[@]}" | grep -w "$VAR_HASH"
	then
		ARRAY_HASH+=("$VAR_HASH")
	else
		ARRAY_DUP+=("$VAR_FILE")
	fi
done
FUNC_MODE
}

#function size (check files with same size)
FUNC_SIZE() {
while IFS= read -r VAR_FILE
do
	clear
	echo "Checking files size before hashing $VAR_FILE. Please wait."
	VAR_SIZE=$(stat -c %s "$VAR_FILE")
	if ! echo "${ARRAY_SIZE[@]}" | grep -w "$VAR_SIZE"
	then
		ARRAY_SIZE+=("$VAR_SIZE")
	else
		ARRAY_FILE+=("$VAR_FILE")
	fi
done < <(find "$VAR_DIR" -type f)
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
