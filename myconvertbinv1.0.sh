#!/bin/bash
# Convert bin to dec, hex, oct and vice versa by dejavudf
# version 1.0 - built 20241121
# Debian/Ubuntu/Mint

FUNC_SCREEN() {
VAR_LOOPING=1
until [ "$VAR_LOOPING" -eq 0 ]
do
	clear
	echo "###############################################"
	echo "# Convert bin to dec, hex, oct and vice versa # "
	echo "# by dejavudf - Version 1.0                   #"
	echo "# Site: https://github.com/dejavudf           #"
	echo "###############################################"
	echo "# Pres CTRL + C to Quit                       #"
	echo "###############################################"
done
}

FUNC_CONVERT() {
	FUNC_SCREEN
 	echo -n "Value to Convert: "
	read VAR_VALUE
	#DEC TO HEX
	VAR_DEC_HEX=$(echo "obase=2; ibase=16; A" | bc)
 	#echo "obase=16; 10" | bc
	#DEC TO OCT
	VAR_DEC_OCT=$(echo "obase=2; ibase=16; A" | bc)
	#DEC TO BIN
	VAR_DEC_BIN=$(echo "obase=2; ibase=16; A" | bc)
	#BIN TO HEX
	VAR_BIN_HEX=$(echo "obase=2; ibase=16; A" | bc)
	#BIN TO DEC
	VAR_BIN_DEC=$(echo "obase=2; ibase=16; A" | bc)
	#BIN TO OCT
	VAR_BIN_OCT=$(echo "obase=2; ibase=16; A" | bc)
	#HEX TO DEC
	VAR_HEX_DEC=$(echo "obase=2; ibase=16; A" | bc)
	#HEX TO OCT
	VAR_HEX_OCT=$(echo "obase=2; ibase=16; A" | bc)
	#HEX TO BIN
	VAR_HEX_BIN=$(echo "obase=2; ibase=16; A" | bc)
	#OCT TO DEC
 	VAR_OCT_DEC=$(echo "obase=10, ibase=8; 17" | bc)
	#OCT TO HEX
        VAR_OCT_HEX=$(echo "obase=16; ibase=8; 17" | bc)
	#OCT TO BIN
 	VAR_OCT_BIN=$(echo "obase=2; ibase=8; 17" | bc)
 	FUNC_SCREEN
	FUNC_RESULT
}

FUNC_RESULT() {
	echo -"Value to Convert: $VAR_VALUE"
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
		echo "Binalry to Octal: $VAR_BIN_OCT"
	#HEX TO DEC
		echo "Hexadecimal to Decimal: $VAR_HEX_DEC"
	#HEX TO OCT
		echo "Hexadecimal to Octal: $VAR_HEX_OCT"
	#HEX TO BIN
	#?
	#OCT TO DEC
	#OCT TO HEX
	#OCT TO BIN
}

FUNC_CONVERT
