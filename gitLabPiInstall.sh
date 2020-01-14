#!/bin/bash
# Install to make a GitLab on the raspberry pi

echo ""

# Verify we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install curl openssh-server ca-certificates postfix apt-transport-https -y

echo "Hit Internet Site if you want to send e-mails from your personal GitLab"
echo ""
echo "[Hit Enter]"

read INPUT

curl https://packages.gitlab.com/gpg.key | sudo apt-key add -


sudo curl -sS https://packages.gitlab.com/install/repositories/gitlab/raspberry-pi2/script.deb.sh | sudo bash
sudo apt-get install gitlab-ce

sudo gitlab-ctl reconfigure

echo "After reboot visit Raspberry Pi IP and configure from there"

echo "Here is your IP"
hostname -I

echo "Hit ENTER to continue"
read INPUT

echo "Install finished"
echo "REBOOTING"
sudo reboot --