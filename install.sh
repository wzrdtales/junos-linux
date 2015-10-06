#!/usr/bin/env bash

if [ ! -f /usr/bin/apt ]; then
  echo "This script is made for debian or debian based OS. You need to adapt it if you're from another platform!"
  exit 1
fi

echo "Please login to your sudo rights, we need to install some packages!"
sudo -k
sudo -v
