#!/bin/bash

#Set the directory where to store the data
Data_dir=/home/pi/Data/

#Query the temperature sensors, get each device, strip the temperature out and drop the notation
Int_temp=`/usr/local/bin/temper-poll |grep 'Device #1'|gawk '{print $3}'|sed 's/°C//'`
Ext_temp=`/usr/local/bin/temper-poll |grep 'Device #0'|gawk '{print $3}'|sed 's/°C//'`

#Echo the date and time into the log with the temperature
when=`date +%s`
thetime=`date +%D' '%T`
#if [ -n "$Int_temp" ]; then
        echo $when $Int_temp $thetime>> $Data_dir/Int_temp.dat
        echo $when $Ext_temp $thetime>> $Data_dir/Ext_temp.dat
#fi

#Ocassionally the sensor gives a bogus reading, so strip out values of 77.3 from the logs
cd $Data_dir
sed -i '/\<77.3\>/d' Int_temp.dat
sed -i '/\<77.3\>/d' Ext_temp.dat
