#!/bin/bash
echo Checking out master branch...
git checkout master
echo Updating to latest version...
git pull origin master
echo Starting OpenHAB...
./start.sh