#!/bin/bash
# A fazer. inicio em 17/10/2024 desafio.
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
VAR_WINNER_PLAYER=0

CHECK_WINNER()
        {
                if [ $VAR_P1 == $VAR_P2 ] && [ $VAR_P2 == $VAR_P3 ]

        }

CHECK_GAME()
        {
                if [ $VAR_P1 == $VAR_P2 ] && [ $VAR_P2 == $VAR_P3 ]
                then
                       CHECK_WINNER
                elif [ $VAR_P4 == $VAR_P5 ] && [ $VAR_P5 == $VAR_P6 ]
                then
                        CHECK_WINNER
                elif [ $VAR_P7 == $VAR_P8 ] && [ $VAR_P8 == $VAR_P9 ]
                then
                        CHECK_WINNER
                elif [ $VAR_P1 == $VAR_P4 ] && [ $VAR_P4 == $VAR_P7 ]
                then
                        CHECK_WINNER
                elif [ $VAR_P2 == $VAR_P5 ] && [ $VAR_P5 == $VAR_P8 ]
                then
                        CHECK_WINNER
                elif [ $VAR_P3 == $VAR_P6 ] && [ $VAR_P6 == $VAR_P9 ]
                then
                        CHECK_WINNER
                elif [ $VAR_P1 == $VAR_P5 ] && [ $VAR_P5 == $VAR_P9 ]
                then
                        CHECK_WINNER
                else
                        VAR_WINNER=0
                fi
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

