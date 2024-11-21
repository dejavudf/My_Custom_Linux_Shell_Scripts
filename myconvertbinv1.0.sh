#!/bin/bash
# Convert bin to dec, hex, oct and vice versa by dejavudf
# version 1.0 - built 20241121
# Debian/Ubuntu/Mint

FUNC_SCRENN() {
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
	VAR_DEC_HEX=$(printf "%x\n" "$VAR_VALUE" 2> /dev/null)
		echo "Decimal to Hexadecimal: $VAR_DEC_HEX"
	#DEC TO OCT
	VAR_DEC_OCT=$(printf "%o\n" "$VAR_VALUE" 2> /dev/null)
		echo "Decimal to Octal: $VAR_DEC_OCT"
	#DEC TO BIN
	VAR_DEC_BIN=$(echo "obase=2;$VAR_VALUE" | bc 2> /dev/null)
		echo "Decimal to Binary: $VAR_DEC_BIN"
	#BIN TO HEX
	VAR_BIN_HEX=$(printf "%x\n" $((2#$VAR_VALUE)) 2> /dev/null)
		echo "Binary to Hexadecimal: $VAR_BIN_HEX"
	#BIN TO DEC
	VAR_BIN_DEC=$(printf "%d\n" $((2#$VAR_VALUE)) 2> /dev/null)
		echo "Binary to Decimal: $VAR_BIN_DEC"
	#BIN TO OCT
	VAR_BIN_OCT=$(printf "%o\n" $((2#$VAR_VALUE)) 2> /dev/null)
		echo "Binalry to Octal: $VAR_BIN_OCT"
	#HEX TO DEC
	VAR_HEX_DEC=$(printf "%d\n" 0x$VAR_VALUE 2> /dev/null)
		echo "Hexadecimal to Decimal: $VAR_HEX_DEC"
	#HEX TO OCT
	VAR_HEX_OCT=$(printf "%o\n" 0x$VAR_VALUE 2> /dev/null)
		echo "Hexadecimal to Octal: $VAR_HEX_OCT"
	#HEX TO BIN
	#?
	#OCT TO DEC
	#OCT TO HEX
	#OCT TO BIN
	sleep 10000
}

FUNC_CONVERT
