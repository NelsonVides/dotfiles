#!/bin/bash

if [ "$1" == "L" ]; then
	dir="west"
	pos="left"
elif [ "$1" == "R" ]; then
	dir="east"
	pos="right"
else
	echo "No position selected. Defaulting to \"Left\""
	dir="west"
	pos="left"
fi
chmod +x ~/.vnc/xstartup #just in case
vncserver -alwaysshared :7 #start the VNC server

#Friendly print the ip address for the iPad to connect to
INPUT=`ifconfig wlp59s0 | grep "inet"`
IP_ADDR=`echo $INPUT | cut -d' ' -f 2`
echo "iPad Monitor enabled to the $pos of the primary screen."
echo "Start VNC client on the iPad and connect to IP $IP_ADDR::5901"
echo "Press Ctrl+C to disable the iPad monitor"
echo "Run the share_clip.sh script in a new terminal window to enable clipboard sharing"
###

#share the mouse and keyboard
x2x -$dir -to :7

#cleanup before exit
function finish {
	vncserver -kill :7 #Disable the VNC server
	echo "iPad Monitor disabled."
}
