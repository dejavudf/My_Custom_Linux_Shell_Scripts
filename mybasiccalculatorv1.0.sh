#!/bin/bash
# mybasiccalculator by dejavudf
# version 1.0 - built 20241117
# Debian/Ubuntu/MintUbuntu

#func clear var (restart calc)
FUNC_CLEAR_VAR() {
VAR_TOTAL="?"
VAR_LEFT_VALUE="x"
VAR_RIGHT_VALUE="y"
VAR_OPERATION="?"
VAR_LEFT_VALUE_VALIDATION=1
VAR_RIGHT_VALUE_VALIDATION=1
VAR_OPERATION_VALIDATION=1
VAR_STEP=1
FUNC_SCREEN
}

#func main menu screen
FUNC_SCREEN() {
clear
echo "[---------------------]"
echo "| My Basic Calculater |"
echo "| by Dejavudf         |"
echo "|---------------------|"
echo "|  1  |  2  |  3 || + |"
echo "|----------------||---|"
echo "|  4  |  5  |  6 || - |"
echo "|----------------||---|"
echo "|  7  |  8  |  9 || x |"
echo "|----------------||---|"
echo "|     |  0  |    || / |"
echo "|---------------------|"
echo "|   CTRL + c to Quit  |"
echo "[---------------------]"
echo "Formula: ($VAR_LEFT_VALUE $VAR_OPERATION $VAR_RIGHT_VALUE) = $VAR_TOTAL"
if [ "$VAR_LEFT_VALUE_VALIDATION" == 1 ] || [ "$VAR_STEP" == 1 ]
then
	FUNC_GET_LEFT_VALUE
elif [ "$VAR_OPERATION_VALIDATION" == 1 ] || [ "$VAR_STEP" == 2 ]
then
	FUNC_GET_OPERATION
elif [ "$VAR_RIGHT_VALUE_VALIDATION" == 1 ] || [ "$VAR_STEP" == 3 ]
then
	FUNC_GET_RIGHT_VALUE
elif [ "$VAR_STEP" == 4 ]
then
	echo "Result: $VAR_TOTAL"
	sleep 10
	FUNC_CLEAR_VAR
fi
}

#func get left value
FUNC_GET_LEFT_VALUE() {
until [ "$VAR_LEFT_VALUE_VALIDATION" == 0 ]
do
	echo -n "Left value (x): "
	read -r VAR_LEFT_VALUE
	if [[ "$VAR_LEFT_VALUE" =~ ^[+-]?[0-9]+$ ]] || [[ "$VAR_LEFT_VALUE" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]
	then
		VAR_LEFT_VALUE_VALIDATION=0
		VAR_STEP=2
		FUNC_SCREEN
	else
		VAR_LEFT_VALUE_VALIDATION=1
		VAR_LEFT_VALUE="x"
		FUNC_SCREEN
	fi
done
}

#func get operation
FUNC_GET_OPERATION() {
until [ "$VAR_OPERATION_VALIDATION" == 0 ]
do
	echo -n "Math Operation: "
	read -r VAR_OPERATION
	case "$VAR_OPERATION" in
		+)
			VAR_OPERATION="+"
			VAR_OPERATION_VALIDATION=0;;
		-)
			VAR_OPERATION="-"
			VAR_OPERATION_VALIDATION=0;;
		x)
			VAR_OPERATION="*"
			VAR_OPERATION_VALIDATION=0;;
		/)
			VAR_OPERATION="/"
			VAR_OPERATION_VALIDATION=0;;
		*)
			VAR_OPERATION_VALIDATION=1
			VAR_OPERATION="?"
			FUNC_SCREEN;;
	esac
done
VAR_STEP=3
FUNC_SCREEN
}

#func get right value
FUNC_GET_RIGHT_VALUE() {
until [ "$VAR_RIGHT_VALUE_VALIDATION" == 0 ]
do
        echo -n "Right value (y): "
        read -r VAR_RIGHT_VALUE
	if [[ "$VAR_RIGHT_VALUE" =~ ^[+-]?[0-9]+$ ]] || [[ "$VAR_RIGHT_VALUE" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]
        then
                VAR_RIGHT_VALUE_VALIDATION=0
		VAR_STEP=4
		FUNC_GET_CALC
        else
                VAR_RIGHT_VALUE_VALIDATION=1
		VAR_RIGHT_VALUE="y"
		FUNC_SCREEN
        fi
done
}

#func get calculation
FUNC_GET_CALC() {
VAR_TOTAL=$(echo | awk '{printf "%0.2f\n", ('$VAR_LEFT_VALUE' '$VAR_OPERATION' '$VAR_RIGHT_VALUE');}')
#VAR_TOTAL=$(expr "$VAR_LEFT_VALUE" "$VAR_OPERATION" "$VAR_RIGHT_VALUE")
VAR_STEP=4
FUNC_SCREEN
}

FUNC_CLEAR_VAR
