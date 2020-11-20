#!/bin/bash

# Volume state output
VOL="$(amixer get Master | awk 'NR==6 {print $5}' | sed 's/\[//;s/\]//;s/%//')"
MUTE="$(amixer get Master | awk 'NR==6 {print $6}' | sed 's/[^a-z]//g')"

[ $VOL -le 5 ] && VOLSTATE="ﱝ"
[ $VOL -le 30 ] && VOLSTATE="奄"
[ $VOL -gt 30 ] && [ $VOL -le 70 ] && VOLSTATE="奔"
[ $VOL -gt 70 ] && VOLSTATE="墳"

[ $MUTE == 'off' ] && VOLSTATE="婢"

echo "^c#fb4934^ ${VOL}% ${VOLSTATE} ^d^"
