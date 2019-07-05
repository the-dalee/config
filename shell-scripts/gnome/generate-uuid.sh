#!/bin/sh
UUID=$(uuidgen | tr -d '\n')
notify-send -t 5000 "UUID generated" "UUID $UUID was copied to the clipboard"
printf "$UUID" | xsel -ib

