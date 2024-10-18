#!/bin/bash
# mytictoctoe game (jogo da velha) by dejavudf
# version 1.0 - built 20241018
# Ubuntu/Debian

#Var Posisitons
#----------------
#| P1 | P2 | P3 |
#----------------
#| P4 | P5 | P6 |
#----------------
#| P7 | P8 | P9 |
#----------------

VAR_P1="1"
VAR_P2="2"
VAR_P3="3"
VAR_P4="4"
VAR_P5="5"
VAR_P6="6"
VAR_P7="7"
VAR_P8="8"
VAR_P9="9"
VAR_COUNT=1
VAR_WINNER=0
VAR_WINNER_PLAYER=0
VAR_PLAYER=1
VAR_PLAY=0
VAR_PLAY_VALIDATION=1

CHECK_WINNER()
	{
		if [ $VAR_P1 == $VAR_P2 ] && [ $VAR_P2 == $VAR_P3 ]
                then
			VAR_WINNER=1
			VAR_WINNER_PLAYER=$VAR_P1
                elif [ $VAR_P4 == $VAR_P5 ] && [ $VAR_P5 == $VAR_P6 ]
                then
                        VAR_WINNER=1
			VAR_WINNER_PLAYER=$VAR_P4
                elif [ $VAR_P7 == $VAR_P8 ] && [ $VAR_P8 == $VAR_P9 ]
                then
                        VAR_WINNER=1
			VAR_WINNER_PLAYER=$VAR_P7
                elif [ $VAR_P1 == $VAR_P4 ] && [ $VAR_P4 == $VAR_P7 ]
                then
                        VAR_WINNER=1
                        VAR_WINNER_PLAYER=$VAR_P1
                elif [ $VAR_P2 == $VAR_P5 ] && [ $VAR_P5 == $VAR_P8 ]
                then
			VAR_WINNER=1
			VAR_WINNER_PLAYER=$VAR_P2
                elif [ $VAR_P3 == $VAR_P6 ] && [ $VAR_P6 == $VAR_P9 ]
                then
                        VAR_WINNER=1
                        VAR_WINNER_PLAYER=$VAR_P3
                elif [ $VAR_P1 == $VAR_P5 ] && [ $VAR_P5 == $VAR_P9 ]
                then
                        VAR_WINNER=1
                        VAR_WINNER_PLAYER=$VAR_P1
		elif [ $VAR_P7 == $VAR_P5 ] && [ $VAR_P5 == $VAR_P3 ]
                then
                        VAR_WINNER=1
                        VAR_WINNER_PLAYER=$VAR_P7
		else
                        VAR_WINNER=0
                fi
        }

while [ $VAR_COUNT -lt 11 ]
do
	if [ $(($VAR_COUNT%2)) == 0 ]
	then
		VAR_PLAYER=2
	else
		VAR_PLAYER=1
	fi
	until [ $VAR_PLAY_VALIDATION == 0 ]
	do
		clear
       		echo "-------------"
        	echo  "| $VAR_P1 | $VAR_P2 | $VAR_P3 |"
        	echo "-------------"
        	echo  "| $VAR_P4 | $VAR_P5 | $VAR_P6 |"
        	echo "-------------"
        	echo  "| $VAR_P7 | $VAR_P8 | $VAR_P9 |"
        	echo "-------------"
        	if [ $VAR_WINNER = 1 ]
		then
			if [ $VAR_WINNER_PLAYER = X ]
			then
				echo "O Jogador 1 (X) vencedor!"
				exit 0
			elif [ $VAR_WINNER_PLAYER = O ]
			then
				echo "O Jogador 2 (O) é o vencedor!"
				exit 0
			fi
		else
			:
		fi
		if [ $VAR_COUNT == 10 ]
		then
			break
		else
			:
		fi
		echo "Jogada $VAR_COUNT de 9"
		echo -n "Jogador $VAR_PLAYER, escolha a posição: "
        	read -n 1 VAR_PLAY
		if [[ ! $VAR_PLAY =~ ^[1-9]+$ ]]
		then
			VAR_PLAY_VALIDATION=1
		else
			echo "$VAR_P1 $VAR_P2 $VAR_P3 $VAR_P4 $VAR_P5 $VAR_P6 $VAR_P7 $VAR_P8 $VAR_P9" | grep -i $VAR_PLAY 3>&2 2>&1 1>&3
			if [ $? == 0 ]
			then
				if [ $VAR_PLAYER == 1 ]
				then
					eval VAR_P${VAR_PLAY}=X
					VAR_PLAY_VALIDATION=0
				elif [ $VAR_PLAYER == 2 ]
				then
					eval VAR_P${VAR_PLAY}=O
					VAR_PLAY_VALIDATION=0
				fi
			else
				VAR_PLAY_VALIDATION=1
			fi
		fi
	done
	VAR_COUNT=$((VAR_COUNT+1))
	VAR_PLAY_VALIDATION=1
	CHECK_WINNER
	if [ $VAR_WINNER = 1 ]
	then
		:
	else
		:
	fi
done
if [ $VAR_WINNER = 0 ]
then
	echo "O jogo terminou empatado"
else
	exit 0
fi
