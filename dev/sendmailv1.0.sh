#!/bin/bash

#Variables
VAR_DT=$(date '+%Y%m%d');
VAR_SERVER="smtp.teste.net:25"
VAR_FROM="alerta@teste.com.br"
VAR_TO="teste@teste.com"
VAR_SUBJ=""
VAR_MESSAGE=""
VAR_FILE=""
VAR_CHARSET="utf-8"
VAR_LOG="./mailto.log"
VAR_CONTENT="message-content-type=auto"

#function send email
FUNC_SEND() {
./mailto -l $VAR_LOG -o $VAR_CONTENT -o $VAR_FILE -s $VAR_SERVER -f $VAR_FROM -t $VAR_TO -u $VAR_SUBJ -m $VAR_MESSAGE -v -o message-charset=$VAR_CHARSET
}

#script begin

#validate status script backup core
if [ -f "./bckcores/"$VAR_DT""_"failure.log" ]
then
	VAR_SUBJ="Erro no script de backup COREs"
	VAR_FILE="message-file=./bckcores/"$VAR_DT"_failure.log"
	FUNC_SEND
fi

#validate status script backup controladoras identify
if [ -f "./bckcontroladoras/"$VAR_DT""_"failure.log" ]
then
        VAR_SUBJ="Erro no backup Controladoras"
        VAR_FILE="message-file=./bckcontroladoras/"$VAR_DT"_failure.log"
        FUNC_SEND
fi

#validate status script backup audit, detectar aps com injetor poe e historico lldp
if [ -f "./bckaudit/"$VAR_DT""_"failure.log" ]
then
        VAR_SUBJ="Erro(s) no(s) script(s) de backup audit logs, detecta APs injetores POE e coleta histÃ³rico LLDP"
        VAR_FILE="message-file=./bckaudit/"$VAR_DT"_failure.log"
        FUNC_SEND
fi
