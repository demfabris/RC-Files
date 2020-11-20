#!/bin/bash

# Wifi SSID and strengh

STR="$(grep wlo1 /proc/net/wireless | awk '{print $4}' | sed 's/[^0-9]//g')"
STR=$((STR-30))
SSID="$(iw dev | grep ssid | awk '{print $2}')"
ISTATE="^c#8ec07c^"

[ "$STR" -lt 35 ] && ICON=" " && ISTATE="^c#689d6a^"
[ "$STR" -ge 35 ] && ICON="說" && ISTATE="^c#d79921^"
[ "$STR" -ge 55 ] && ICON="罹 " && ISTATE="^c#d65d0e^"

curl www.google.com.br &>/dev/null || ICON=" " ISTATE="^c#fe8019^"

[ -z $SSID ] && SSID="off" && ICON="ﲁ " && ISTATE="^c#cc241d^"

echo "^c#282828^${ISTATE} ${SSID} ${ICON} ^d^"
