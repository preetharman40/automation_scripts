#!/bin/bash

#/home/kali/hackthebox/stocker/nmap

file="/home/kali/hackthebox/stocker/nmap"


Address=None
Status=None
Open=None

# Extract IP Address from nmap script

while read line
do
  #echo $line

  IP=$(echo $line | awk '/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ { print $5 }')


  # IP=$(echo $line | grep -E '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}' | cut -d" " -f5 )
  if [ -z $IP ]
  then
    continue
  fi
  Address=$IP
  echo $Address


done < $file



echo "========================= Nmap Report for $Address ============================="

# Extract whether Host is up or down

Status=$(awk '/^Host is up/ { print $3 }' $file)
echo $Status


if [[ $Status == "up" ]]
then
   cat <<EOF
     
                         ***** Host $Address is UP *****

EOF

else
  echo "***** Host $Address is DOWN *****"
fi

# Extracting Opened Ports


while read line
do
  port=$(echo $line | awk '/^[0-9]{1,5}\/[tcp|udp]/ { print $1 }'| cut -d"/" -f1 )

  service=$(echo $line | awk '/^[0-9]{1,5}\/[tcp|udp]/ { print $3 }')

  version=$(echo $line | awk '/^[0-9]{1,5}\/[tcp|udp]/ { print $4,$5,$6,$7,$8 }')

  if [ -z $port ] || [ -z $service ] || [ -z $version ] 2>/dev/null
  then
    continue
  fi

  cat << EOF
      
    Opened Port: $port
    Service    : $service
    version    : $version


EOF


done < $file
