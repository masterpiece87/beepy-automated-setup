#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SCHEDULED_FUNCTIONS_FOLDER=/home/scheduled
CUSTOMFUNCTIONS=/home/beepyfunctions

# UPDATE DRIVERS
sudo apt update
sudo apt-get -y install beepy-kbd sharp-drm

# UPDATE CUSTOM SCRIPTS

sudo wget https://raw.githubusercontent.com/masterpiece87/beepy-hacks/mainline/scripts/battery.sh -O $SCHEDULED_FUNCTIONS_FOLDER/battery.sh
sudo chmod +x $SCHEDULED_FUNCTIONS_FOLDER/battery.sh
sudo wget https://raw.githubusercontent.com/masterpiece87/beepy-hacks/mainline/scripts/wx -O $CUSTOMFUNCTIONS/wx
sudo chmod +x $CUSTOMFUNCTIONS/wx

