#!/bin/bash
echo Checking out master branch...
git checkout master
echo Updating to latest version...
git pull origin master

echo Cleaning up used GPIO pins...
pins = (5 13 17)
for pin in pins    # Five lines.
do
  printf "Cleaning pin ${Line[pin]}..."
  sudo sh -c 'echo ${Line[pin]} > /sys/class/gpio/unexport'
done

sudo ./start.sh
