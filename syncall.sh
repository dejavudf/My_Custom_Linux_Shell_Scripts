#!/bin/bash
# by dejavudf
# version 1.0 20241103
# debian/ubunt/mint

#variables
VAR_SERVER="192.168.0.254"
VAR_BAR="###################################"

FUNC_BANNER() {
echo "$VAR_BAR"
echo "# Pi2 Ubutu Server Backup Scripts #"
echo "$VAR_BAR"
echo "# Checking server connectivity... #"
echo "$VAR_BAR"
FUNC_CHECK
}

#func copy files
FUNC_COPY() {
if scp -r ./* alexsandro@"$VAR_SERVER":/home/alexsandro/bck_pi2 >/dev/null 2>&1
then
	echo "Status: Backup completed successfuly."
	sleep 2
	exit 0
else
	echo "Status: Backup error or not completed."
fi
}

#func check server connectivity
FUNC_CHECK() {
if ping -c 3 "$VAR_SERVER" >/dev/null 2>&1
then
	echo "Starting backup. Please, wait..."
	FUNC_COPY
else
	echo "Status: Server is down. Try agan later."
	sleep 2
	exit 1
fi
}

#script begin
FUNC_BANNER
