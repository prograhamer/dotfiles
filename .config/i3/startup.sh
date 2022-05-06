set -x

gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpiuug

# xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
# screen before suspend. Use loginctl lock-session to lock your screen.
xss-lock --transfer-sleep-lock -- $i3lock --nofork

# NetworkManager is the most popular way to manage wireless networks on Linux,
# and nm-applet is a desktop environment-independent system tray GUI for it.
nm-applet &

# Compton to prevent screen tearing
# compton --config ~/.config/compton.conf -b

# Set keyboard map
setxkbmap us

firefox &
