#!/bin/bash
# We need this for later
workingDirectory=$(pwd)
echo "[+] We are currently in $workingDirectory"
echo ""
echo "[+] Waiting for 3 seconds..."
sleep 3
echo "[+] Making directory for Phrack Magazine"
mkdir phrackMagazine
echo "[+] Downloading All Phrack Archives"
# Recursive, no parent directory, reject all index.html files and anything that follows index.html
wget -r --no-parent --reject="index.html*" http://www.phrack.org/archives/tgz/
# Getting the number of files we have downloaded
numberOfFiles=$(ls -l $workingDirectory/www.phrack.org/archives/tgz | wc -l)
fileCountActual=$(expr $numberOfFiles - 1)
# Shows number of current issues downloaded
echo ""
echo "[+] Current number of issues: $fileCountActual" 
echo ""
echo "[+] Sleeping for 3 seconds..."
sleep 3
# Moving the files we got from Phrack and putting them in a new folder
mv $workingDirectory/www.phrack.org/archives/tgz/* $workingDirectory/phrackMagazine/
# Removing old file
rm -rf $workingDirectory/www.phrack.org
#cd $workingDirectory/phrackMagazine
# Creating directories for the files to stay in
for ((i=1; i<=fileCountActual; i++))
do
	DIRECTORY="phrack$i"
	mkdir $DIRECTORY
done

for ((i=1; i<=fileCountActual; i++))
do
	FILE="phrack$i.tar.gz"
	DIRECTORY="phrack$i"
	tar xvzf phrackMagazine/$FILE -C $workingDirectory/$DIRECTORY
	rm -rf phrackMagazine/$FILE
done

for ((i=1; i<=fileCountActual; i++))
do
	mv $workingDirectory/phrack$i $workingDirectory/phrackMagazine
done

echo "[+] DONE [+]"