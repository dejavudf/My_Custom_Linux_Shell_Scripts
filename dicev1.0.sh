#!/bin/bash

#variables
VAR_KEY="a"

FUNC_PLAY_1()
{
	echo " ------- "
	echo "|       |"
	echo "|   *   |"
	echo "|       |"
	echo " ------- "
}

FUNC_PLAY_2()
{
     	echo " ------- "
      	echo "|  *    |"
      	echo "|       |"
      	echo "|    *  |"
      	echo " ------- "
}

FUNC_PLAY_3()
{
      	echo " ------- "
      	echo "| *     |"
      	echo "|   *   |"
      	echo "|     * |"
      	echo " ------- "
}

FUNC_PLAY_4()
{
       	echo " ------- "
       	echo "| *   * |"
       	echo "|       |"
       	echo "| *   * |"
       	echo " ------- "
}

FUNC_PLAY_5()
{
       	echo " ------- "
       	echo "| *   * |"
       	echo "|   *   |"
	echo "| *   * |"
      	echo " ------- "
}

FUNC_PLAY_6()
{
       	echo " ------- "
       	echo "| *   * |"
       	echo "| *   * |"
       	echo "| *   * |"
       	echo " ------- "
}

FUNC_PLAY_DICE()
{
until [ "$VAR_KEY" == "q" ] || [ "$VAR_KEY" == "Q" ]
do
	clear
	echo "#########################################"
	echo "#                                       #"
	echo "#               Dice Game               #"
	echo "#                                       #"
	echo "#########################################"
	echo "# Press Q/q and <ENTER> to quit.        #"
	echo "#########################################"
	echo -n "Press <ENTER> to Play dice: "
	read -r VAR_KEY
	if [ "$VAR_KEY" == "q" ] || [ "$VAR_KEY" == "Q" ]
	then
		exit 0
	else
		VAR_VALUE=$(shuf -i 1-6 -n 1)
		case "$VAR_VALUE" in
			1)
				FUNC_PLAY_1
				;;
			2)
				FUNC_PLAY_2
				;;
			3)
				FUNC_PLAY_3
				;;
			4)
				FUNC_PLAY_4
				;;
			5)
				FUNC_PLAY_5
				;;
			6)
				FUNC_PLAY_6
				;;
			*)
		esac
		echo -n "<ENTER>"
		read -r VAR_KEY
	fi
done
exit 0
}

FUNC_PLAY_DICE
