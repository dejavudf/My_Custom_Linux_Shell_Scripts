#!/bin/bash
# by Alexsandro - github/dejavudf
# v1.1 - 21/05/2025
# debian/ubuntu/mint
#formato arquivo ipsopmon.txt: basta ter os ips dentros do arquivo (areas: services e hosts)
#formato arquivo ipsxmc.csv (arquivo exportado do xmc).

#variables
VAR_INPUT_FILE=$1
VAR_NAME_OUT="saida"

#script
pdftoppm -W 1176 -H 673 -x 32 -y 184 -png $VAR_INPUT_FILE $VAR_NAME_OUT



