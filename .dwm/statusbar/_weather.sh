# _weather.sh

# Weather info

TEMP="$(curl -s http://wttr.in/Piracicaba?format=1)"

[ "$TEMP" ] && 
TEMP=$(echo $TEMP | sed 's/[^0-9+°A-Z\-]//g') &&
ICON=$(echo $TEMP | sed 's/[0-9+°A-Z]//g') ;

[ "$TEMP" ] && echo "${TEMP} ${ICON} "
[ "$TEMP" ] || echo "勒 "
