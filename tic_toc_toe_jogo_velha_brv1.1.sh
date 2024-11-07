#!/bin/bash
# mytictoctoe game (jogo da velha) by dejavudf
# version 1.1 - built 20241107
# tested and validated on debian/ubuntu/mint

#Var Posisitons
#----------------
#| P1 | P2 | P3 |
#----------------
#| P4 | P5 | P6 |
#----------------
#| P7 | P8 | P9 |
#----------------
#possible winner combinations x 8
# 1 -> P1=P2=P3
# 2 -> P4=P5=P6
# 3 -> P7=P8=P9
# 4 -> P1=P4=P7
# 5 -> P2=P5=P8
# 6 -> P3=P6=P9
# 7 -> P1=P5=P9
# 8 -> P3=P5=P7

#variables
#array positions: P1=0, P2=1, P3=2, P4=3, P5=4, P6=5, P7=6, P8=7 and P9=8
VAR_GAME_ARRAY=(0 1 2 3 4 5 6 7 8)
VAR_COUNT=1
VAR_WINNER=0
VAR_WINNER_PLAYER=0
VAR_PLAYER=1
VAR_PLAY=0
VAR_PLAY_VALIDATION=1

CHECK_WINNER()
	{
		if [ "${VAR_GAME_ARRAY[0]}" == "${VAR_GAME_ARRAY[1]}" ] && [ "${VAR_GAME_ARRAY[1]}" == "${VAR_GAME_ARRAY[2]}" ]
                then
			VAR_WINNER=1
			VAR_WINNER_PLAYER="${VAR_GAME_ARRAY[0]}"
                elif [ "${VAR_GAME_ARRAY[3]}" == "${VAR_GAME_ARRAY[4]}" ] && [ "${VAR_GAME_ARRAY[4]}" == "${VAR_GAME_ARRAY[5]}" ]
                then
                        VAR_WINNER=1
			VAR_WINNER_PLAYER="${VAR_GAME_ARRAY[3]}"
                elif [ "${VAR_GAME_ARRAY[6]}" == "${VAR_GAME_ARRAY[7]}" ] && [ "${VAR_GAME_ARRAY[7]}" == "${VAR_GAME_ARRAY[8]}" ]
                then
                        VAR_WINNER=1
			VAR_WINNER_PLAYER="${VAR_GAME_ARRAY[6]}"
                elif [ "${VAR_GAME_ARRAY[0]}" == "${VAR_GAME_ARRAY[3]}" ] && [ "${VAR_GAME_ARRAY[3]}" == "${VAR_GAME_ARRAY[6]}" ]
                then
                        VAR_WINNER=1
                        VAR_WINNER_PLAYER="${VAR_GAME_ARRAY[0]}"
                elif [ "${VAR_GAME_ARRAY[1]}" == "${VAR_GAME_ARRAY[4]}" ] && [ "${VAR_GAME_ARRAY[4]}" == "${VAR_GAME_ARRAY[7]}" ]
                then
			VAR_WINNER=1
			VAR_WINNER_PLAYER="${VAR_GAME_ARRAY[1]}"
                elif [ "${VAR_GAME_ARRAY[2]}" == "${VAR_GAME_ARRAY[5]}" ] && [ "${VAR_GAME_ARRAY[5]}" == "${VAR_GAME_ARRAY[8]}" ]
                then
                        VAR_WINNER=1
                        VAR_WINNER_PLAYER="${VAR_GAME_ARRAY[2]}"
                elif [ "${VAR_GAME_ARRAY[0]}" == "${VAR_GAME_ARRAY[4]}" ] && [ "${VAR_GAME_ARRAY[4]}" == "${VAR_GAME_ARRAY[8]}" ]
                then
                        VAR_WINNER=1
                        VAR_WINNER_PLAYER="${VAR_GAME_ARRAY[0]}"
		elif [ "${VAR_GAME_ARRAY[2]}" == "${VAR_GAME_ARRAY[4]}" ] && [ "${VAR_GAME_ARRAY[4]}" == "${VAR_GAME_ARRAY[6]}" ]
                then
                        VAR_WINNER=1
                        VAR_WINNER_PLAYER="${VAR_GAME_ARRAY[2]}"
		else
                        VAR_WINNER=0
                fi
        }

while [ "$VAR_COUNT" -lt 11 ]
do
	if [ $((VAR_COUNT%2)) == 0 ]
	then
		VAR_PLAYER=2
	else
		VAR_PLAYER=1
	fi
	until [ "$VAR_PLAY_VALIDATION" == 0 ]
	do
		clear
       		echo "-------------"
        	echo  "| ${VAR_GAME_ARRAY[0]} | ${VAR_GAME_ARRAY[1]} | ${VAR_GAME_ARRAY[2]} |"
        	echo "-------------"
        	echo  "| ${VAR_GAME_ARRAY[3]} | ${VAR_GAME_ARRAY[4]} | ${VAR_GAME_ARRAY[5]} |"
        	echo "-------------"
        	echo  "| ${VAR_GAME_ARRAY[6]} | ${VAR_GAME_ARRAY[7]} | ${VAR_GAME_ARRAY[8]} |"
        	echo "-------------"
        	if [ "$VAR_WINNER" = 1 ]
		then
			if [ "$VAR_WINNER_PLAYER" = X ]
			then
				echo "O Jogador 1 (X) vencedor!"
				exit 0
			elif [ "$VAR_WINNER_PLAYER" = O ]
			then
				echo "O Jogador 2 (O) é o vencedor!"
				exit 0
			fi
		else
			:
		fi
		if [ "$VAR_COUNT" == 10 ]
		then
			break
		else
			:
		fi
		echo "Jogada $VAR_COUNT de 9"
		echo -n "Jogador $VAR_PLAYER, escolha a posição: "
        	read -r -n 1 VAR_PLAY
		if [[ ! "$VAR_PLAY" =~ ^[0-8]+$ ]]
		then
			VAR_PLAY_VALIDATION=1
		else
			if echo "${VAR_GAME_ARRAY[*]}" | grep -i "$VAR_PLAY" 3>&2 2>&1 1>&3
			then
				if [ "$VAR_PLAYER" == 1 ]
				then
					VAR_GAME_ARRAY[$VAR_PLAY]=X
					VAR_PLAY_VALIDATION=0
				elif [ "$VAR_PLAYER" == 2 ]
				then
					VAR_GAME_ARRAY[$VAR_PLAY]=O
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
	if [ "$VAR_WINNER" = 1 ]
	then
		:
	else
		:
	fi
done
if [ "$VAR_WINNER" = 0 ]
then
	echo "O jogo terminou empatado"
else
	exit 0
fi
