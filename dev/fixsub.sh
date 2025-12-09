#!/bin/bash
# GetSubtitle script by dejavudf
# version 1.1 - built 20251209
# debian/ubuntu/mint

#run with parameters: login password

#variables

FUNC_FIX_SUB() {
find ./ -type f | grep -i ".srt" | while read -r VAR_FILE
do
        VAR_SIZE=$(stat "$VAR_FILE" | grep -i Size | awk '{print $2}')
        if [ "$VAR_SIZE" = "102" ]
	then
		rm "$VAR_FILE"
	else
		VAR_NEW_NAME=$(echo "$VAR_FILE" | sed  -e 's/\.en//g');
                if [ "$VAR_FILE" != "$VAR_NEW_NAME" ]
		then
			mv "$VAR_FILE" "$VAR_NEW_NAME"
		else
			continue
		fi
	fi
done
}

FUNC_FIX_SUB
