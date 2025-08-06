#!/bin/bash

VAR_DATE=$(date '+%Y%m%d_%H:%M')
VAR_TIME=1800

nohup ping 177.23.109.90 -c $VAR_TIME > ./177.23.109.90_$VAR_DATE.txt &
nohup ping 177.23.109.89 -c $VAR_TIME > ./177.23.109.89_$VAR_DATE.txt &
nohup ping 200.169.70.129 -c $VAR_TIME > ./200.169.70.129_$VAR_DATE.txt &
nohup ping 200.169.70.130 -c $VAR_TIME > ./200.169.70.130_$VAR_DATE.txt &

