#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

KEYPATH="https://raw.githubusercontent.com/masterpiece87/beepy-ppa/master/KEY.gpg"
PACKAGESOURCE="https://raw.githubusercontent.com/masterpiece87/beepy-ppa/master/beepy.list"
SCHEDULED_FUNCTIONS_FOLDER=/home/scheduled
CUSTOMFUNCTIONS=/home/beepyfunctions
UPDATE_SCRIPT=https://raw.githubusercontent.com/masterpiece87/beepy-automated-setup/main/scripts/update.sh


curl -s --compressed $KEYPATH | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/beepy.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/beepy.list $PACKAGESOURCE
sudo apt update
sudo apt-get -y install beepy-kbd sharp-drm

# CUSTOM SCRIPTS INSTALLATION
sudo mkdir $CUSTOMFUNCTIONS
sudo mkdir $SCHEDULED_FUNCTIONS_FOLDER
sudo wget https://raw.githubusercontent.com/masterpiece87/beepy-hacks/mainline/scripts/battery.sh -O $SCHEDULED_FUNCTIONS_FOLDER/battery.sh
sudo chmod +x $SCHEDULED_FUNCTIONS_FOLDER/battery.sh
sudo wget https://raw.githubusercontent.com/masterpiece87/beepy-hacks/mainline/scripts/wx.sh -O $CUSTOMFUNCTIONS/wx.sh
sudo chmod +x $CUSTOMFUNCTIONS/wx.sh



# Battery LED schedule
sudo echo "* * * * * root (           "$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") > "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all
sudo echo "* * * * * root ( sleep 20 ;"$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") > "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all
sudo echo "* * * * * root ( sleep 40 ;"$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") > "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all

# System Update Schedule
sudo echo "0 0 * * * root (curl -s "$UPDATE_SCRIPT" | bash ) > "$SCHEDULED_FUNCTIONS_FOLDER"/update.log" >> /etc/cron.d/e2scrub_all

# Update font to standard one.
sudo sed -i 's/8x8/8x16/g' /boot/cmdline.txt


sudo reboot