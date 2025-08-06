#!/bin/bash

VAR_DATE=$(date '+%Y%m%d_%H:%M')
VAR_TIME=1800

nohup ping 1.1.1.1 -c $VAR_TIME > ./1.1.1.1.txt &

