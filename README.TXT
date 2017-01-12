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
view openHAB in browser at http://192.168.0.106:8080/openhab.app?sitemap=cumberland

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

This is where I learned how to connect the 433mhz RF transmitter and receiver.
It led me to install WiringPi and RcSwitch, which was not needed up until this. That allowed
me to send a command over an RF signal. Make sure to set up and export the proper pin numbers in the send.cpp file.
http://smarthome.hallojapan.de/2014/11/controlling-lights-with-openhab-raspberry-pi-and-433mhz-remote-switches/

Then I needed to follow these http://www.princetronics.com/how-to-read-433-mhz-codes-w-raspberry-pi-433-mhz-receiver/
in order to receive signals so I could sniff the signals I needed to send over. Make sure to set up and export the proper pin numbers in the RFSniffer.cpp file.
It uses 433Utils: https://github.com/ninjablocks/433Utils
I got a lot of help from http://www.makeuseof.com/tag/control-cheap-rf-power-sockets-openhab/, namely that I needed to pay attention to protocol, bitlength, and delay as well as just decimal code.


These are all installed in /opts/433mhz-transceiver directory for right now.

STEPS TO GET 433MHz codes:
1. download 433Utils from https://github.com/ninjablocks/433Utils, do the deep clone to get rc-switch as well.
2. download wiringPi and run `./build`
3. change the PIN number in 433Utils/RPi_utils/RFSniffer.cpp to the appropriate wiringPi number from this chart: http://binnie.id.au/Downloads/pins.pdf
4. add additional code to the display of the result so you can read the protocol, bitlength, and delay as well as just the decimal code.

```printf("Received value: %i protocol: %i bitlength: %i delay %i\n", 
	mySwitch.getReceivedValue(),
	mySwitch.getReceivedProtocol(),
	mySwitch.getReceivedBitlength(),
	mySwitch.getReceivedDelay() 
  );```
	  
5. run `make` in 433Utils/RPi_utils
6. run `sudo ./RFSniffer` and then press the buttons on the remote while close range to the receiver.
7. write down the code, delay, protocol, and bitlength for each button you want to control.

STEPS TO SEND 433MHz codes:
1. follow steps 1, 2 above.
2. set the PIN in the same fashion as above for /codesend.cpp. the send.cpp file is not used, so don't worry about that.
3. run `make` in /433Utils/RPi_utils.
4. send the code by running `sudo ./codesend decimalCode protocolNumber delayNumber`. The bitlength is hardcoded to 24 for now, maybe you'll have to change that. if so, remember to run `make` again on the code.

Hooking 433 up to Openhab was as easy as setting up a rule that executeCommandLine() with the command above.
Remember to set the chmod to allow the openhab user to execute the file: `chmod 777 codesend`
I made a helper function that sends the code 3 times, it is in /opt/433-transceiver/RCSwitch.sh, you use it the same way you would codesend.

5 original switches:
delay: 180-184, protocol: 1, bitlength: 24
1, on = 4199731, off = 4199740
2, on = 4199875, off = 4199884
3, on = 4200195, off = 4200204
4, on = 4201731, off = 4201740
5, on = 4207875, off = 4207884

antenna for the 433mhz transmitter should be about 17.2cm in a straight line, no need for receiver antenna because it doesn't matter the range as long as it can receive.
