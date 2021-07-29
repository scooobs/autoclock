#!/bin/bash

h=$(date +'%l')
mins=$(date +'%M')
v=0
if [ $mins -ge 15 ]
then
    v=30
fi
if [ $mins -ge 45 ]
then
    h=$((($h+1)%12))
    v=0
fi

key=$(head -n 1 ./api_key.txt)

if [ $v -eq 0 ]
then
    sw=":clock$h:"
    s="$(echo -e "${sw}" | tr -d '[:space:]')"
    curl -i -u scooobs:$key https://api.github.com/user -d " \
 { \
   \"bio\": \"$s\" \
 } \
"
else
    sw=":clock$h$v:"
    s="$(echo -e "${sw}" | tr -d '[:space:]')"
    curl -i -u scooobs:$key https://api.github.com/user -d " \
 { \
   \"bio\": \"$s\" \
 } \
"
fi
