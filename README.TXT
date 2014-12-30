==============================================================================
===                  openHAB - the open Home Automation Bus               ====
===                          http://www.openHAB.org                       ====
===                                                                       ====
===                                 RUNTIME                               ====
==============================================================================

This zip file contains the core runtime package of openHAB.

See http://code.google.com/p/openhab/wiki/Setup for setup and
configuration instructions.


My notes:

ssh pi@raspberrypi
password: raspberry

There is a daemon on startup that runs whatever code is currently on the pi.

to stop this daemon, /etc/init.d/openhab [stop/start/restart]
https://github.com/openhab/openhab/wiki/Samples-Tricks

./deploy -g to get the newest code and start the service (no -g if no need to pull code).

install owfs for one-wire sensors, monitors, etc. http://www.raspberrypi.org/forums/viewtopic.php?t=27379&p=505250
https://github.com/openhab/openhab/wiki/One-Wire-Binding
