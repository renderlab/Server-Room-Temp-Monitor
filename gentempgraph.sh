#!/bin/bash

DATA_Dir=/home/pi/Data

TODAY=`date "+%m/%d/%y %H:%M:%S"`
YESTERDAY=`date "+%m/%d/%y %H:%M:%S" --date="-1 day"`
DAILY=`date "+%m/%d/%y %H:%M:%S" --date="-12 hour"`
WEEK=`date "+%m/%d/%y" --date="-7 day"`
MONTH=`date "+%m/%d/%y" --date="-1 month"`

gnuplot <<-EOF

set term png size 1024, 2048
set output '$DATA_Dir/Temp.png'
#unset key
set key left top
set ylabel 'Temperature (Celsius)'
set border 3
set xtics nomirror
set xtics rotate
set ytics nomirror
unset xlabel
set multiplot layout 4, 1 title "Temperatures"

		set title 'By Hour'
                set xdata time
                set timefmt "%m/%d/%y %H:%M:%S"
                set format x "%m/%d/%y %H:%M:%S"
                set xtics autofreq
                set xrange ["$DAILY":"$TODAY"]
		plot '$DATA_Dir/Int_temp.dat' u 3:2 t 'Interior Temp Profile' lc 2 smooth sbezier, '$DATA_Dir/Int_temp.dat' every 300 u 3:2 t 'Interior Temp Points' w points lc 2 pt 1 ps 1, '$DATA_Dir/Ext_temp.dat' u 3:2 t 'Exterior Temp Profile' lc 1 smooth sbezier, '$DATA_Dir/Ext_temp.dat' every 300 u 3:2 t 'Exterior Temp Points' w points lc 1 pt 1 ps 1

                set title 'By Day'
                set xdata time
                set timefmt "%m/%d/%y"
                set format x "%m/%d/%y"
                set xtics autofreq
                set xrange ["$YESTERDAY":"$TODAY"]
                plot '$DATA_Dir/Int_temp.dat' u 3:2 t 'Interior Temp Profile' lc 2 smooth sbezier, '$DATA_Dir/Int_temp.dat' every 300 u 3:2 t 'Interior Temp Points' w points lc 2 pt 1 ps 1, '$DATA_Dir/Ext_temp.dat' u 3:2 t 'Exterior Temp Profile' lc 1 smooth sbezier, '$DATA_Dir/Ext_temp.dat' every 300 u 3:2 t 'Exterior Temp Points' w points lc 1 pt 1 ps 1

                set title 'By Week'
		set xdata time
                set timefmt "%m/%d/%y"
                set format x "%m/%d/%y"
                set xtics autofreq
                set xrange ["$WEEK":"$TODAY"]
		plot '$DATA_Dir/Int_temp.dat' u 3:2 t 'Interior Temp Profile' lc 2 smooth sbezier, '$DATA_Dir/Int_temp.dat' every 300 u 3:2 t 'Interior Temp Points' w points lc 2 pt 1 ps 1, '$DATA_Dir/Ext_temp.dat' u 3:2 t 'Exterior Temp Profile' lc 1 smooth sbezier, '$DATA_Dir/Ext_temp.dat' every 300 u 3:2 t 'Exterior Temp Points' w points lc 1 pt 1 ps 1

		set timefmt "%m/%d/%y %H:%M:%S"
                set xdata time
                set title 'Monthly'
                set format x "%m/%d/%y"
                set xrange ["$MONTH":"$TODAY"]
                set xtics autofreq
		plot '$DATA_Dir/Int_temp.dat' u 3:2 t 'Interior Temp Profile' lc 2 smooth sbezier, '$DATA_Dir/Int_temp.dat' every 300 u 3:2 t 'Interior Temp Points' w points lc 2 pt 1 ps 1, '$DATA_Dir/Ext_temp.dat' u 3:2 t 'Exterior Temp Profile' lc 1 smooth sbezier, '$DATA_Dir/Ext_temp.dat' every 300 u 3:2 t 'Exterior Temp Points' w points lc 1 pt 1 ps 1

EOF

cp $DATA_Dir/Temp.png /var/www/html
