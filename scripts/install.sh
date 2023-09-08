#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

KEYPATH="https://raw.githubusercontent.com/masterpiece87/beepy-ppa/master/KEY.gpg"
PACKAGESOURCE="https://raw.githubusercontent.com/masterpiece87/beepy-ppa/master/beepy.list"
SCHEDULED_FUNCTIONS_FOLDER=/home/scheduled


curl -s --compressed $KEYPATH | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/beepy.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/beepy.list $PACKAGESOURCE
sudo apt update
sudo apt-get -y install beepy-kbd sharp-drm

sudo mkdir $SCHEDULED_FUNCTIONS_FOLDER
sudo wget https://raw.githubusercontent.com/masterpiece87/beepy-hacks/mainline/scripts/battery.sh -O $SCHEDULED_FUNCTIONS_FOLDER/battery.sh

sudo echo "* * * * * root (           "$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") >> "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all
sudo echo "* * * * * root (           "$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") >> "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all
sudo echo "* * * * * root ( sleep 10 ;"$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") >> "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all
sudo echo "* * * * * root ( sleep 20 ;"$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") >> "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all
sudo echo "* * * * * root ( sleep 30 ;"$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") >> "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all
sudo echo "* * * * * root ( sleep 40 ;"$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") >> "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all
sudo echo "* * * * * root ( sleep 50 ;"$SCHEDULED_FUNCTIONS_FOLDER"/battery.sh" ") >> "$SCHEDULED_FUNCTIONS_FOLDER"/batteryjob.log" >> /etc/cron.d/e2scrub_all


# sudo reboot