Int_temp=`/usr/local/bin/temper-poll |grep 'Device #0'|gawk '{print $3}'|sed 's/°C//' | cut -c 1-2`
Ext_temp=`/usr/local/bin/temper-poll |grep 'Device #1'|gawk '{print $3}'|sed 's/°C//' | cut -c 1-2`

#echo $Int_temp
#echo $Ext_temp


HIGHTEMP=26
LOWTEMP=22
#echo $HIGHTEMP
#echo $LOWTEMP

if [ "$Int_temp" -gt "$HIGHTEMP" ]
then
        `usbrelay YSM6Q_2=1 &> /dev/null`
	echo "Fan is ON" > fanstatus

#elif [ "$Int_temp" -lt "$HIGHTEMP" ]
else
	`usbrelay YSM6Q_2=0 &> /dev/null`
	echo "Fan is OFF" > fanstatus

fi
