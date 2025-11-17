#!/bin/bash
# by dejavudf/alexsandro farias - github.com/dejavudf
# version 1.1 17/11/2025
# calc md5 has on all files and folders - subtree
# debian/ubuntu/mint

#variables
VAR_DATE=$(date '+%Y_%m_%d_%H_%M_%S')
VAR_FILE_TMP="./tree.tmp"

#script
FUNC_CALC_HASH_TREE()
{
rm -f "$VAR_FILE_TMP"
find ./ -type f -name '*' > "$VAR_FILE_TMP"
cat < "$VAR_FILE_TMP" | while read -r VAR_FILE
do
        VAR_RESULT=$(md5sum "$VAR_FILE")
        echo "Date/Hour: $(date '+%Y/%m/%d/-%H:%M:%S') - MD5 Hash and File Path/Name: $VAR_RESULT" >> ./"$VAR_DATE""_md5.txt"
done
}

FUNC_CALC_HASH_TREE
exit 0
