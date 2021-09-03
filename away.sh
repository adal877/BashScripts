#!/bin/sh

# Declare the log file
logfile="$HOME/.irssi/away.log"

# If the $logfile doesn't exist, then create it
[ ! -e "$logfile" ] && touch "$logfile"

# Put this script on polybar
# If notify-send it's running, then kill it
killall -q notify-send

# Verify the log file
tail -n0 -f "$logfile" | xargs -I{} notify-send "@Irssi" "{}"


#echo 61 64 61 6C 38 37 37 | xxd -r -p | xargs -I{} printf "{}\n"
