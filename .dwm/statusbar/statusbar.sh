#!/bin/bash

# This is the wrapper script for all status bar functions, all contents are
# imported by the main function

main() {

# . ~/.dwm/statusbar/_traffic.sh ;
. ~/.dwm/statusbar/_wifi.sh ;
. ~/.dwm/statusbar/_battery.sh ;
. ~/.dwm/statusbar/_audio.sh ;
. ~/.dwm/statusbar/_cpu.sh ;
. ~/.dwm/statusbar/_displaytime.sh ;

}

# while true;
#     do xsetroot -name "$(main | tr "\n" " ")"
#         sleep 1;
# done;
