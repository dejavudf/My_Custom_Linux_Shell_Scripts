#!/bin/bash
# by dejavudf - github.com/dejavudf
# version 1.1 15/06/2026
# debian/ubuntu/mint
# find and check/remove duplicated files inside a directory tree (folder and subfolders)

#variables declarations
VAR_MODE=0
VAR_ARRAY_SIZE=()
VAR_ARRAY_HASH=()
VAR_ARRAY_DUP=()
VAR_ARRAY_FILE=()
VAR_FILE=""
VAR_HASH=""

#function mode (check or remove)
FUNC_MODE() {
if [ "$VAR_MODE" == "0" ]
then
	echo "Duplicated files list:"
	echo "${ARRAY_DUP[@]}"
elif [ "$VAR_MODE" == "1" ]
then
	while IFS= read -r VAR_FILE
	do
		if rm /y "$VAR_FILE"
		then
			echo "$VAR_FILE" >> ./success.log
		else
			echo "$VAR_FILE" >> ./error.log
		fi
	done < echo "${ARRAY_DUP[@]}"
	clear
	echo "Script completed. Please, check files:"
	echo "./success.log to check success"
	echo "./error.log to check errors"
	exit 0
fi
}

#function hash (calc file md5 hash)
FUNC_HASH() {
while IFS= read -r VAR_FILE
do
	VAR_HASH=$(md5sum "$VAR_FILE" | awk '{print $1}')
	if ! echo "${ARRAY_HASH[@]}" | grep -w "$VAR_HASH"
	then
		ARRAY_HASH+=("$VAR_HASH")
	else
		ARRAY_DUP+=("$VAR_FILE")
	fi
done < echo "${ARRAY_FILE[@]}"
FUNC_MODE
}

#function size (check files with same size)
FUNC_SIZE() {
while IFS= read -r VAR_FILE
do
	VAR_SIZE=$(stat -c %S "$VAR_FILE")
	if ! echo "${ARRAY_SIZE[@]}" | grep -w "$VAR_SIZE"
	then
		ARRAY_SIZE+=("$VAR_SIZE")
	else
		ARRAY_FILE+=("$VAR_FILE")
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
