#!/bin/bash
# Convert bin to dec, hex, oct and vice versa by dejavudf - not using bc, using printf and others. Using bc (check version 1.0)
# version 1.1 - built 20241122
# Debian/Ubuntu/Mint

#variables
VAR_VALUE=""
VAR_DEC_HEX=""
VAR_DEC_OCT=""
VAR_DEC_BIN=""
VAR_BIN_HEX=""
VAR_BIN_DEC=""
VAR_BIN_OCT=""
VAR_HEX_DEC=""
VAR_HEX_OCT=""
VAR_HEX_BIN=""
VAR_OCT_DEC=""
VAR_OCT_HEX=""
VAR_OCT_BIN=""
VAR_HEX_VALUE=""
VAR_BASE=""
VAR_RESULT=""
VAR_HEX_VALUE=""
VAR_COUNT=""

FUNC_SCREEN() {
clear
echo "###############################################"
echo "# Convert bin to dec, hex, oct and vice versa # "
echo "# by dejavudf - Version 1.1                   #"
echo "# Site: https://github.com/dejavudf           #"
echo "###############################################"
echo "# Pres CTRL + C to Quit                       #"
echo "###############################################"
}

FUNC_CONVERT() {
FUNC_SCREEN
echo -n "Value to Convert: "
read -r VAR_VALUE
if [[ "$VAR_VALUE" =~ ^[0-9]+$ ]]
then
	#DEC TO HEX
	VAR_DEC_HEX=$(printf "%x\n" "$VAR_VALUE" | tr '[:lower:]' '[:upper:]')
	#DEC TO OCT
	VAR_DEC_OCT=$(printf "%o\n" "$VAR_VALUE")
	#DEC TO BIN
	VAR_VALUE_NUM="$VAR_VALUE"
	VAR_OP=2
	VAR_QUO=$(( "$VAR_VALUE_NUM" / "$VAR_OP" ))
	VAR_REM=$(( "$VAR_VALUE_NUM" % "$VAR_OP"))
	array=()
    	array+=("$VAR_REM")
        until [[ "$VAR_QUO" -eq 0 ]]
	do
		VAR_VALUE_NUM="$VAR_QUO"
		VAR_QUO=$(( "$VAR_VALUE_NUM" / "$VAR_OP"))
		VAR_REM=$(( "$VAR_VALUE_NUM" % "$VAR_OP"))
        	array+="$VAR_REM"
        done
    	VAR_BIN=$(echo "${array[@]}" | rev)
    	VAR_DEC_BIN=$(printf "$VAR_BIN\n")
fi
if [[ "$VAR_VALUE" =~ ^[0-1]+$ ]]
then
	#BIN TO HEX
	VAR_BIN_HEX=$(printf "%x\n" $((2#"$VAR_VALUE")))
	#BIN TO DEC
	VAR_BIN_DEC=$(printf "%d\n" $((2#"$VAR_VALUE")))
	#BIN TO OCT
	VAR_BIN_OCT=$(printf "%o\n" $((2#"$VAR_VALUE")))
fi
if [[ "$VAR_VALUE" =~ ^[0-7]+$ ]]
then
	#OCT TO DEC
 	VAR_OCT_DEC=$(echo "$((8#$VAR_VALUE))")
	#OCT TO HEX (OCT TO DEC TO HEX)
        VAR_OCT_HEX=$(echo "$((8#$VAR_VALUE))")
	VAR_OCT_HEX=$(printf "%x\n" "$VAR_OCT_HEX" | tr '[:lower:]' '[:upper:]')
	#OCT TO BIN (OCT TO DEC TO BIN)
 	VAR_OCT_BIN=$(echo "$((8#$VAR_VALUE))")
	VAR_VALUE_NUM="$VAR_OCT_BIN"
        VAR_OP=2
        VAR_QUO=$(( "$VAR_VALUE_NUM" / "$VAR_OP" ))
        VAR_REM=$(( "$VAR_VALUE_NUM" % "$VAR_OP"))
        array=()
        array+=("$VAR_REM")
        until [[ "$VAR_QUO" -eq 0 ]]
        do
                VAR_VALUE_NUM="$VAR_QUO"
                VAR_QUO=$(( "$VAR_VALUE_NUM" / "$VAR_OP"))
                VAR_REM=$(( "$VAR_VALUE_NUM" % "$VAR_OP"))
                array+="$VAR_REM"
        done
        VAR_BIN=$(echo "${array[@]}" | rev)
        VAR_OCT_BIN=$(printf "$VAR_BIN\n")

fi
if (( 16#"$VAR_VALUE" ))
then
	#HEX TO DEC
	VAR_VALUE=$(echo "$VAR_VALUE" | tr '[:lower:]' '[:upper:]')
	VAR_HEX_DEC=$(printf "%d\n" 0x"$VAR_VALUE")
	#HEX TO OCT
	VAR_HEX_OCT=$(printf "%o\n" 0x"$VAR_VALUE")
	#HEX TO BIN
	VAR_HEX_BIN=$(echo "$VAR_VALUE" | awk 'BEGIN {
	FS=""
	a["f"]="1111"
	a["e"]="1110"
	a["d"]="1101"
	a["c"]="1100"
	a["b"]="1011"
	a["a"]="1010"
	a["9"]="1001"
	a["8"]="1000"
	a["7"]="0111"
	a["6"]="0110"
	a["5"]="0101"
	a["4"]="0100"
	a["3"]="0011"
	a["2"]="0010"
	a["1"]="0001"
	a["0"]="0000"
	}
	{
	for (VAR_COUNT=1;VAR_COUNT<=NF;VAR_COUNT++) printf a[tolower($VAR_COUNT)]
	print ""
	}')
fi
FUNC_SCREEN
FUNC_RESULT
}

FUNC_RESULT() {
	echo "Value to Convert: $VAR_VALUE"
 	#DEC TO HEX
	echo "Decimal to Hexadecimal: $VAR_DEC_HEX"
	#DEC TO OCT
	echo "Decimal to Octal: $VAR_DEC_OCT"
	#DEC TO BIN
	echo "Decimal to Binary: $VAR_DEC_BIN"
	#BIN TO HEX
	echo "Binary to Hexadecimal: $VAR_BIN_HEX"
	#BIN TO DEC
	echo "Binary to Decimal: $VAR_BIN_DEC"
	#BIN TO OCT
	echo "Binary to Octal: $VAR_BIN_OCT"
	#HEX TO DEC
	echo "Hexadecimal to Decimal: $VAR_HEX_DEC"
	#HEX TO OCT
	echo "Hexadecimal to Octal: $VAR_HEX_OCT"
	#HEX TO BIN
 	echo "Hexadecimal to Binary: $VAR_HEX_BIN"
	#OCT TO DEC
 	echo "Octal to Decimal: $VAR_OCT_DEC"
	#OCT TO HEX
 	echo "Octal to Hexadecimal: $VAR_OCT_HEX"
	#OCT TO BIN
 	echo "Octal to Binary: $VAR_OCT_BIN"
  	sleep 40
  	FUNC_CONVERT
}

#script begin
if bc --help 2>/dev/null
then
	FUNC_CONVERT
else
	echo "bc is not installed. Please install via command: apt-get install bc"
	sleep 10
	exit 1
fi
