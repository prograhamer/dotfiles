#!/bin/bash

set -x

# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# screen before suspend. Use loginctl lock-session to lock your screen.
# xss-lock --transfer-sleep-lock -- $i3lock --nofork

# Set keyboard map
# setxkbmap us

# pasystray &

firefox &
