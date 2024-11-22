#!/bin/bash
# Convert bin to dec, hex, oct and vice versa by dejavudf
# version 1.0 - built 20241121
# Debian/Ubuntu/Mint

#variables
VAR_VALUE=“”
VAR_DEC_HEX=“”
VAR_DEC_OCT=“”
VAR_DEC_BIN=“”
VAR_BIN_HEX=“”
VAR_BIN_DEC=“”
VAR_BIN_OCT=“”
VAR_HEX_DEC=“”
VAR_HEX_OCT=“”
VAR_HEX_BIN=“”
VAR_OCT_DEC=“”
VAR_OCT_HEX=“”
VAR_OCT_BIN=“”

FUNC_SCREEN() {
clear
echo "###############################################"
echo "# Convert bin to dec, hex, oct and vice versa # "
echo "# by dejavudf - Version 1.0                   #"
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
	VAR_DEC_HEX=$(echo "obase=16; ibase=10; $VAR_VALUE" | bc)
	#DEC TO OCT
	VAR_DEC_OCT=$(echo "obase=8; ibase=10; $VAR_VALUE" | bc)
	#DEC TO BIN
	VAR_DEC_BIN=$(echo "obase=2; ibase=10; $VAR_VALUE" | bc)
fi
if [[ "$VAR_VALUE" =~ ^[0-1]+$ ]]
then
	#BIN TO HEX
	VAR_BIN_HEX=$(echo "obase=16; ibase=2; $VAR_VALUE" | bc)
	#BIN TO DEC
	VAR_BIN_DEC=$(echo "obase=10; ibase=2; $VAR_VALUE" | bc)
	#BIN TO OCT
	VAR_BIN_OCT=$(echo "obase=8; ibase=2; $VAR_VALUE" | bc)
fi
if [[ "$VAR_VALUE" =~ ^[0-7]+$ ]]
then
	#OCT TO DEC
 	VAR_OCT_DEC=$(echo "obase=10; ibase=8; $VAR_VALUE" | bc)
	#OCT TO HEX
        VAR_OCT_HEX=$(echo "obase=16; ibase=8; $VAR_VALUE" | bc)
	#OCT TO BIN
 	VAR_OCT_BIN=$(echo "obase=2; ibase=8; $VAR_VALUE" | bc)
fi
if (( 16#"$VAR_VALUE" ))
then
	#HEX TO DEC
	VAR_VALUE=$(echo "$VAR_VALUE" | tr '[:lower:]' '[:upper:]')
	VAR_HEX_DEC=$(echo "obase=10; ibase=16; $VAR_VALUE" | bc)
	#HEX TO OCT
	VAR_HEX_OCT=$(echo "obase=8; ibase=16; $VAR_VALUE" | bc)
	#HEX TO BIN
	VAR_HEX_BIN=$(echo "obase=2; ibase=16; $VAR_VALUE" | bc)
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
