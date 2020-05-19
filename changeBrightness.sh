#!/bin/bash

# function:
# change brigthness via script, max and min brightness is toggled
#
# usage:
# brightnessChange addend
# addend is float value ranging from -2.0 to 2.0
#
# dependencies:
# schreen needs to be set in CPV_SCREEN env variable, otherwise first found connected screen is used
# xrandr

addend=$1

#screen=$()
screen=`printenv CPV_SCREEN`
if [ -z "$screen" ]
then
    screens=`xrandr | grep " connected" | cut -f1 -d " "`
    screen=${screens%$'\n'*}
fi
brightness=$(xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' ')
goalBrightness=$(echo "$brightness + $addend" | bc)
maxBrightness="2.0"
minBrightness="0.0"

echo "screen affected: $screen"
echo "current brightness $brightness"
echo "addend: $addend"
echo "goal brightness: $goalBrightness"
echo "maxBrightness: $maxBrightness"
echo "minBrightness: $minBrightness"

if (( $(echo "$goalBrightness > $maxBrightness" |bc -l) )); then
	echo "too Bright, setting to max Brightness instead"
	xrandr --output "$screen" --brightness $maxBrightness
elif (( $(echo "$goalBrightness < $minBrightness" |bc -l) )); then
	echo "too doom, setting to min Brightness instead"
	xrandr --output "$screen" --brightness $minBrightness
else
	xrandr --output "$screen" --brightness $goalBrightness
fi



newBrightness=$(xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' ')
echo "brightness is now set to: $newBrightness"
