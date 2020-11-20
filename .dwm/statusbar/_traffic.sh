#!/bin/sh

# Module showing network traffic. Shows how much data has been received (RX) or
# transmitted (TX) since the previous time this script ran. So if run every
# second, gives network traffic per second.

rxfile="${XDG_CACHE_HOME:-$HOME/.cache}/rxlog"
txfile="${XDG_CACHE_HOME:-$HOME/.cache}/txlog"

rxcurrent="$(cat /sys/class/net/*/statistics/rx_bytes | paste -sd '+' | bc)"
txcurrent="$(cat /sys/class/net/*/statistics/tx_bytes | paste -sd '+' | bc)"

printf "^c#83a598^ ^d^%sk ^c#83a598^ ^d^%sk " \
	"$(printf -- "(%s-%s)/1024\\n" "$rxcurrent" "$(cat "$rxfile")" | bc)" \
	"$(printf -- "(%s-%s)/1024\\n" "$txcurrent" "$(cat "$txfile")" | bc)"

# Log the current values for next run.
echo "$rxcurrent" > "$rxfile"
echo "$txcurrent" > "$txfile"
