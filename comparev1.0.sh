#!/bin/bash
# by Alexsandro - github/dejavudf
# v1.0 - 23/05/2025
# debian/ubuntu/mint
# Compare primary column inside file01.txt versus primary column inside file2.txt - both files with 3 columns. Primary key: column 1.
# Results: only_in_file01.txt, only_in_file02.txt and inside_both_files.txt - Input files formats: col1;col2;col3

#variables
VAR_FILE_01="file01.txt"
VAR_FILE_02="file02.txt"
VAR_IN_FILE01="only_in_file01.txt"
VAR_IN_FILE02="only_in_file02.txt"
VAR_BOTH_FILES="inside_both_files.txt"
VAR_SEPARATOR=";"

rm "$VAR_IN_FILE01" "$VAR_IN_FILE02" "$VAR_BOTH_FILES" > /dev/null 2>&1

FUNC_IN_FILE01() {
cat < ./"$VAR_FILE_01" | while read -r VAR_COLUMNS
do
	VAR_COLUMN_01=$(echo "$VAR_COLUMNS" | awk -F"$VAR_SEPARATOR" '{print $1}')
	VAR_COLUMN_02=$(echo "$VAR_COLUMNS" | awk -F"$VAR_SEPARATOR" '{print $2}')
	VAR_COLUMN_03=$(echo "$VAR_COLUMNS" | awk -F"$VAR_SEPARATOR" '{print $3}')
	clear
	echo 'Working: |'
	clear
	echo 'Working: /'
	clear
	echo 'Working: -'
	clear
	echo 'Working: \'
	if grep -i "$VAR_COLUMN_01" ./"$VAR_FILE_02" > /dev/null 2>&1
	then
		echo "$VAR_COLUMN_01"",""$VAR_COLUMN_02"",""$VAR_COLUMN_03" >> "$VAR_BOTH_FILES"
	else
		echo "$VAR_COLUMN_01"",""$VAR_COLUMN_02"",""$VAR_COLUMN_03" >> "$VAR_IN_FILE01"
	fi
done
}

FUNC_IN_FILE02() {
cat < ./"$VAR_FILE_02" | while read -r VAR_COLUMNS
do
	VAR_COLUMN_01=$(echo "$VAR_COLUMNS" | awk -F"$VAR_SEPARATOR" '{print $1}')
	VAR_COLUMN_02=$(echo "$VAR_COLUMNS" | awk -F"$VAR_SEPARATOR" '{print $2}')
	VAR_COLUMN_03=$(echo "$VAR_COLUMNS" | awk -F"$VAR_SEPARATOR" '{print $3}')
	clear
	echo 'Working: |'
	clear
	echo 'Working: /'
	clear
	echo 'Working: -'
	clear
	echo 'Working: \'
	if grep -i "$VAR_COLUMN_02" ./"$VAR_FILE_01" > /dev/null 2>&1
	then
		if ! grep -i "$VAR_COLUMN_01" "$VAR_BOTH_FILES" > /dev/null 2>&1
		then
			echo "$VAR_COLUMN_01"",""$VAR_COLUMN_02"",""$VAR_COLUMN_03" >> "$VAR_BOTH_FILES"
		fi
	else
		echo "$VAR_COLUMN_01"",""$VAR_COLUMN_02"",""$VAR_COLUMN_03" >> "$VAR_IN_FILE02"
	fi
done
}

FUNC_IN_FILE01
FUNC_IN_FILE02


