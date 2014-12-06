#!/bin/bash
echo Checking out master branch...
git checkout master
echo Updating to latest version...
git pull origin master

echo Cleaning up used GPIO pins...
pins=( 5 13 17 )
for pin in "${pins[@]}"
do
  printf "Cleaning pin ${pin}..."
  sudo sh -c 'echo ${pin} > /sys/class/gpio/unexport'
done

sudo ./start.sh
