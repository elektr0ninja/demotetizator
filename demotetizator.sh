#!/bin/bash
######################################################################
# 
# De-Emotet-Izator script by elektr0ninja, 2019
# ----------
# Simple tool to extract malware download URLs from the
# weaponized Office documents.
#
# Requirements: oledump.py
# Usage:
#
# ./demotetizator.sh <filename.doc>
#
# output:
# filename.doc.ps: the powershell downloader payload
# urls.txt: the extracted urls  
# binary.txt: downloaded binary sample file types, md5 and sha256 hashes 
# doc.txt: md5 and sha256 hashes of the maldoc
# *.exe: downloaded binary samples
# wget.log: output from wget to check which URLs are working

OLEDUMP=~/Tools/oledump/oledump.py

echo "[*] De-Emotet-Izator script by elektr0ninja, 2019"
if [ $# -eq 0 ]
  then
    echo "Usage: ./demotetizator.sh <filename.doc>"
    exit 0;
fi
echo "[*] Processing: $1"
echo "[*] Extracting Powershell script..." 
$OLEDUMP -s a -S $1| strings -n 280 | base64 -d | tr -d '\0' > $1.ps
echo "[*] Done."
echo "[*] Extracting URLS..."
cat $1.ps | tr \' '\n' | tr '@' '\n' | grep http >> urls.txt
echo "[*] Done."
echo "[*] Downloading binaries..."
wget -i urls.txt --content-disposition --no-check-certificate -o wget.log -t 1
echo "[*] Calculating hashes..."
file *.exe > binary.txt
md5sum *.exe >> binary.txt
sha256sum *.exe >> binary.txt
md5sum $1 > doc.txt
echo "[!!] Done. Look at that:"
cat urls.txt
cat binary.txt
