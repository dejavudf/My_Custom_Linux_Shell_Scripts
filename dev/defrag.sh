#!/bin/bash

#variables
VAR_TIME="10"
VAR_LOG_FILE="/tmp/trim.log"
VAR_DIR="/media"

#script
if [ "$VAR_DIR" = "/media" ]
then
	VAR_TMP=$(pwd)
	if [ "$VAR_TMP" = "/tmp" ]
	then
		e4defrag -v "$VAR_DIR" && shutdown -P "$VAR_TIME"
	else
		exit 1
	fi
else
	exit 1
fi
exit 0
