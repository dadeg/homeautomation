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
view openHAB in browser at http://192.168.0.106:8080/openhab.app?sitemap=teekynest

raspberry pi pins numbering http://binnie.id.au/Downloads/pins.pdf

ssh pi@raspberrypi
password: raspberry

There is a daemon on startup that runs whatever code is currently on the pi.

to stop this daemon, /etc/init.d/openhab [stop/start/restart]
Could also use my stop script, ./stop to stop it.
https://github.com/openhab/openhab/wiki/Samples-Tricks

./bootstrap -g to get the newest code and start the service (no -g if no need to pull code).

This is where I learned how to set up the thermometers, which are one-wire sensors.
install owfs for one-wire sensors, monitors, etc. http://www.raspberrypi.org/forums/viewtopic.php?t=27379&p=505250
https://github.com/openhab/openhab/wiki/One-Wire-Binding

If you are experiencing an issue where a button doesn't
stay in a steady state, set up a pull-up or pull-down
resistor to give it a base state.

FOR 433Mhz SWITCHES
install the package https://github.com/dadeg/433mhz-transceiver and follow its instructions

5 original switches:
delay: 180-184, protocol: 1, bitlength: 24
1, on = 4199731, off = 4199740
2, on = 4199875, off = 4199884
3, on = 4200195, off = 4200204
4, on = 4201731, off = 4201740
5, on = 4207875, off = 4207884