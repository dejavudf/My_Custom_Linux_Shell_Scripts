#!/bin/bash
#my progress bar by dejavudf
#version 20241110
#debian/ubuntu/mint

#variables
#parameter input user time var in seconds
VAR_USER_TIME="$1"
VAR_PERCENT=0
VAR_BAR_PROGRESS=0
VAR_BAR_VALUE=
VAR_TIME_RESOLUTION=$((VAR_USER_TIME / 50))
VAR_BAR_EMPTY=50

FUNC_SCREEN() {
clear
echo "[--------------------------------------------------]"
echo "|$VAR_LEFT_BAR$VAR_RIGHT_BAR| $VAR_PERCENT%"
echo "[--------------------------------------------------]"
sleep "$VAR_TIME_RESOLUTION"
}

FUNC_PROGRESS_BAR() {
while [ "$VAR_PERCENT" -le 100 ]
do
	if [ "$VAR_PERCENT" == 0 ] || [ "$VAR_BAR_PROGRESS" == 0 ]
	then
		VAR_RIGHT_BAR=$(eval $(echo printf '" %0.s"' {1..$VAR_BAR_EMPTY}))
		FUNC_SCREEN
		VAR_PERCENT=2
		VAR_BAR_PROGRESS=1
	else
		VAR_BAR_EMPTY=$((VAR_BAR_PROGRESS - 50))
		VAR_BAR_EMPTY=$((VAR_BAR_EMPTY * -1))
		VAR_LEFT_BAR=$(eval $(echo printf '"#%0.s"' {1..$VAR_BAR_PROGRESS}))
		if [ "$VAR_BAR_EMPTY" != 0 ]
		then
			VAR_RIGHT_BAR=$(eval $(echo printf '" %0.s"' {1..$VAR_BAR_EMPTY}))
		else
			VAR_RIGHT_BAR=""
		fi
		FUNC_SCREEN
		VAR_PERCENT=$((VAR_PERCENT + 2))
		VAR_BAR_PROGRESS=$((VAR_BAR_PROGRESS + 1))
	fi
done
exit 0
}

FUNC_PROGRESS_BAR
