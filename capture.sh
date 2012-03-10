#!/bin/sh

# script to screenshot the iPhone Simulator to the correct size
# to upload to iTunes Connect
# written by Jehiah Czebotar http://jehiah.cz/

OUTPUTDIR=~
TEMPFILE=iPhoneSimulatorScreenshot_`date +%Y%m%d_%H%M%S`.png

echo "output filename:\c"
read -e OUTPUTFILE

# activate iPhone Simulator so it's easy to click on 
osascript -e 'tell application "iPhone Simulator"' -e 'activate' -e 'end tell'

# capture the screen
screencapture -iowW $OUTPUTDIR/$TEMPFILE 

# resize to the apple upload size, 320x480
sips -c 1024 768 $OUTPUTDIR/$TEMPFILE --out $OUTPUTDIR/${OUTPUTFILE}_1024
sips -c 768 1024 $OUTPUTDIR/$TEMPFILE --out $OUTPUTDIR/${OUTPUTFILE}_768
sips -c 480 320 $OUTPUTDIR/$TEMPFILE --out $OUTPUTDIR/${OUTPUTFILE}_320
sips -c 320 480 $OUTPUTDIR/$TEMPFILE --out $OUTPUTDIR/${OUTPUTFILE}_480

# resize to something else, say 176x260
#sips -z 260 176 $OUTPUTDIR/$TEMPFILE --out $OUTPUTDIR/$OUTPUTFILE
