# demotetizator
De-Emotet-Izator script for easy extraction of URLs and downloading binaries from weaponized office documents spreading Emotet variants

Simple tool to extract malware download URLs from the weaponized Office documents.

Requirements: oledump.py (get it from here: https://github.com/DidierStevens/DidierStevensSuite/blob/master/oledump.py)

Usage:

 ./demotetizator.sh <filename.doc>

Output:
 
 filename.doc.ps: the powershell downloader payload

 urls.txt: the extracted urls

 binary.txt: downloaded binary sample file types, md5 and sha256 hashes

 doc.txt: md5 and sha256 hashes of the maldoc

 \*.exe: downloaded binary samples

 wget.log: output from wget to check which URLs are working
