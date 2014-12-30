#!/bin/bash

# -g flag for updating codebase before starting up.
while getopts ":g" opt; do
  case $opt in
    g)
    echo Checking out master branch...
    git checkout master
    echo Updating to latest version...
    git pull origin master
    ;;
    \?)
    echo "Invalid option: -$OPTARG" >&2
    ;;
  esac
done

echo Cleaning up GPIO pins that openHAB currently uses...
pins=( 4 5 13 17 18 )
for pin in "${pins[@]}"
do
  echo "Cleaning pin ${pin}..."
  sudo sh -c "echo ${pin} > /sys/class/gpio/unexport"
done

# start OneWire FileSystem (OWFS) for 1-wire temperature/humidity/etc. sensors.
sudo umount /mnt/1wire
sudo modprobe w1-gpio
sudo modprobe w1-therm
sudo owfs -F -uall -m /mnt/1wire --allow_other

sudo ./start.sh
