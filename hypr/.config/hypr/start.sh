#!/bin/sh

# Start polkit authentication agent (for GTK)
if command -v /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 >/dev/null; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# Start other background apps here
# nm-applet &
# waybar &
# etc.