#!/bin/sh

#echo "Creating Directory $1."

DIRECTORY=$1
IP=$2


mkdir $DIRECTORY

echo "Directory $DIRECTORY Created:"

case $3 in
	nmap)
		echo "Running Nmap ==========================="
		echo "========================================"

		nmap -sS -T4 -Pn -A -p- $IP | tee /home/kali/hackthebox/$DIRECTORY/nmap	
		;;
	dirsearch)
		
		echo "Running Directory Brute Forcing===================="
		echo "==================================================="
		
		gobuster dir -u http://$IP/ -x php, py, asp, aspx -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt |  tee -a /home/kali/hackthebox/$DIRECTORY/directory.txt
		;;
	*)
		echo "======================Running Nmap =========================="
		echo "======================================================================================="
		nmap -sS -T4 -Pn -A -p- $IP | tee /home/kali/hackthebox/$DIRECTORY/nmap &
		echo "Nmap Process name: "${!}
		echo "*******************"
	
		echo "===============Running Directory Brute Forcing==============="
		echo "============================================================="
		gobuster dir -u http://$IP/ -x php, py, asp, aspx -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt |  tee -a /home/kali/hackthebox/$DIRECTORY/directory.txt
		
		
		
	esac










