#!/bin/bash
Data_dir=/home/pi/Data

Int_temp=`/usr/local/bin/temper-poll |grep 'Device #0'|gawk '{print $3}'|sed 's/°C//'`
Ext_temp=`/usr/local/bin/temper-poll |grep 'Device #1'|gawk '{print $3}'|sed 's/°C//'`
when=`date +%s`
thetime=`date +%D' '%T`
#if [ -n "$Int_temp" ]; then
        echo $when $Int_temp $thetime>> $Data_dir/Int_temp.dat
        echo $when $Ext_temp $thetime>> $Data_dir/Ext_temp.dat
#fi
sed -i '/\<77.3\>/d' $Data_dir/Int_temp.dat
sed -i '/\<77.3\>/d' $Data_dir/Ext_temp.dat
