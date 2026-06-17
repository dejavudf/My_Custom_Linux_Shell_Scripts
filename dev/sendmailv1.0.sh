#!/bin/bash

#Variables
VAR_DT=$(date '+%Y%m%d');
VAR_SERVER="smpt.teste.com:25"
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
        VAR_SUBJ="Erro(s) no(s) backup(s) COREs teste"
        VAR_FILE="message-file=./bckcores/"$VAR_DT"_failure.log"
        FUNC_SEND
fi
