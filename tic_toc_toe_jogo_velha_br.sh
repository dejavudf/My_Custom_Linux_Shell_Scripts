#!/bin/bash

#Var Posisitons
#----------------
#| P1 | P2 | P3 |
#----------------
#| P4 | P5 | P6 |
#----------------
#| P7 | P8 | P9 |
#----------------

VAR_P1=" "
VAR_P2=" "
VAR_P3=" "
VAR_P4=" "
VAR_P5=" "
VAR_P6=" "
VAR_P7=" "
VAR_P8=" "
VAR_P9=" "
VAR_COUNT=1
VAR_WINNER=0

CHECK_GAME()
        {
                if [ $VARP
        }

while [ $VAR_CONTADOR -lt 10 ]
do
        clear
        echo "-------------"
        echo  "| $VAR_P1 | $VAR_P2 | $VAR_P3 |"
        echo "-------------"
        echo  "| $VAR_P4 | $VAR_P5 | $VAR_P6 |"
        echo "-------------"
        echo  "| $VAR_P7 | $VAR_P8 | $VAR_P9 |"
        echo "-------------"
        sleep 2
        VAR_CONTADOR+=1
        FC_CHECK_GAME
        if [ $VAR_WINNER = 1 ]
        then
                echo "Player 1 (X) wins"
        elif [ $VAR_WINNER = 1 ]
        then
              echo "Player 2 (O) wins"  
        else
                continue
        fi      
done

