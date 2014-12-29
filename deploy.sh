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
pins=( 5 13 17 18 22 )
for pin in "${pins[@]}"
do
  echo "Cleaning pin ${pin}..."
  sudo sh -c "echo ${pin} > /sys/class/gpio/unexport"
done

sudo ./start.sh
