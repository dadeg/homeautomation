#!/bin/bash
echo Checking out master branch...
git checkout master
echo Updating to latest version...
git pull origin master

echo Cleaning up GPIO pins that openHAB currently uses...
pins=( 5 13 17 )
for pin in "${pins[@]}"
do
  echo "Cleaning pin ${pin}..."
  sudo sh -c "echo ${pin} > /sys/class/gpio/unexport"
done

sudo ./start.sh
