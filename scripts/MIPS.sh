#!/bin/bash
# Written by FalsePhilosopher & speedyes

opkg update
opkg install unzip coreutils-rm libpcap1
cd /tmp
wget https://github.com/naixue233/PPPwnWRT_naixue233/blob/main/zips/files.zip
wget https://github.com/naixue233/PPPwnWRT_naixue233/blob/main/zips/MIPS.zip
unzip -d / files.zip
unzip -d / MIPS.zip
rm files.zip MIPS.zip
pppwn list
echo ""
echo -e "\e[1;31mChange stage1.bin, firmware version and interface accordingly in '/etc/pppwnwrt/pppwnwrt.sh'! Start the script AFTER you change these variables! \e[0m"
echo ""
