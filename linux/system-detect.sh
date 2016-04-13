#!/bin/sh

# This code will try to automatically detect known motor/power boards and configure the correctly tailored command for them*/

canTalkToATMEGAviaSPI(){
    avrdude -P /dev/spidev1.0 -c linuxspi -vv -p m2560 > /dev/null 2>&1
    if [ $? -ne 0 ] 
    then
	echo yay
        return 1
    else
	echo boo
        return 0
    fi
    
}

export ROV_BOARD=custom


canTalkToATMEGAviaSPI;
if [ "$?" -eq 1 ];
then
	echo cb
    export ROV_BOARD=board25
else
	echo cape
    export ROV_BOARD=cape
fi

echo "$ROV_BOARD" > /var/run/rov_board

exit 0

