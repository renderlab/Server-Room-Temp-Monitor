Server-Room-Temp-Monitor
========================

Scripts to control the exhaust fan in my home server room based on temperature from cheap USB TEMPer thermometers monitors.

I run two temperature monitors, one for the temperature in the server room and one for outside.  This is so I can adjust the point where the exhaust fan kicks in compared to the external temperature and so that the fan does'nt try and cool the room below the ambient exterior temperature.  It would be easy to add or remove sensors from the graphing. 

The exhaust fan is an ordinary bathroom fan wired into the relay board.  It's cheap and effective.

Hardware:

USB Relay Board: http://www.dx.com/p/keyes-2-way-5v-free-drive-usb-control-switch-relay-module-red-307714
USB Temperature Sensor: http://www.dx.com/p/temper-usb-thermometer-temperature-recorder-for-pc-laptop-81105

Dependancy Projects:

https://github.com/padelt/temper-python
https://github.com/darrylb123/usbrelay

Install the temper-python project according to instructions, especially setting the USB device permissions for non-root use.

Install the USB relay project according to instructions, especially setting the USB device permissions for non-root use.

Dependencies:

Gnuplot - apt-get install gnuplot
Apache2 - apt-get install apache2 (or whatever webserver you prefer, adjust paths as needed)

Install:

Set the "Data_dir" variable in the gettemp.sh and gentempgraph.sh scripts.  This is where the script writes the temperature data and also generates the graph image for the web page.

The script will generate a Monthly, Week, and Daily graph of the temperature.

Copy the index.html file to your webserver root.  Apache's default is /var/www/html.  You will also need to change the ownership on the /var/www/html directory to your non-root user.

Set a cron job for however often you want to take readings.

Script logic:

The gettemp.sh script grabs the current temperatures, parses out the data, time and temperature and writes them to Int_temp.data and Ext_temp.dat

The gentempgraph.sh script runs gnuplot on the data in the Int_temp.data and Ext_temp.dat files and outputs them to a monthly, weekly, and daily plot of the temperatures and outputs it to the Temp.png file.  Then the script copies the Temp.png file to the webroot where the index file loads it and refreshes every minute.
