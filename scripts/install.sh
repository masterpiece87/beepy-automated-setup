#!/bin/bash
KEYPATH="https://raw.githubusercontent.com/masterpiece87/beepy-ppa/master/KEY.gpg"
PACKAGESOURCE="https://raw.githubusercontent.com/masterpiece87/beepy-ppa/master/beepy.list"

curl -s --compressed $KEYPATH | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/beepy.gpg >/dev/null
sudo curl -s --compressed -o /etc/apt/sources.list.d/beepy.list $PACKAGESOURCE
sudo apt update
sudo apt-get -y install beepy-kbd sharp-drm


sudo reboot