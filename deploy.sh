#!/bin/bash
echo Checking out master branch...
git checkout master
echo Updating to latest version...
git pull origin master

echo Cleaning up used GPIO pins...
echo Cleaning pin 5...
sudo sh -c 'echo 5 > /sys/class/gpio/unexport'
echo Cleaning pin 13...
sudo sh -c 'echo 13 > /sys/class/gpio/unexport'

sudo ./start.sh
