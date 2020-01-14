#!/bin/bash
#Install GoPhish, Postfix, and Certbot for Phishing on a Linux machine
#GoPhish may not be the most recent version, I will try to keep this updated

echo "" 

#Verify root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Press ENTER to continue, CTRL+C to abort."
read INPUT
sudo apt update -y
sudo apt upgrade -y 
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install postfix -y
sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt update -y
sudo apt install certbot -y
sudo apt install unzip -y
sudo certbot certonly --standalone --register-unsafely-without-email
sudo wget https://github.com/gophish/gophish/releases/download/v0.8.0/gophish-v0.8.0-linux-64bit.zip
unzip gophish-v0.8.0-linux-64bit.zip
rm -r gophish-v0.8.0-linux-64bit.zip
echo "[+] Ready to configure"
echo "[+] Done"