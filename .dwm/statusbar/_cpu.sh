#!/bin/bash

# Defining color variables
COOL="^c#458588^"
CI=""
WARN="^c#fabd2f^"
WI=""
DANGER="^c#cc241d^"
DI=" "

# Fetching current CPU state
TEMP="$(sensors | grep -e 'id 0\:' | awk '{print $4}' | sed 's/[^0-9\.]//g;s/\.[0-9]//g')"

[ $TEMP -lt 30 ] && STATE="${COOL}" && TSTATE="${CI}"
[ $TEMP -gt 30 ] && [ $TEMP -lt 70 ] && STATE="${WARN}" && TSTATE="${WI}"
[ $TEMP -ge 70 ] && STATE="${DANGER}" && TSTATE="${DI}"

echo "${STATE} ${TEMP}°C ${TSTATE} ^d^"
