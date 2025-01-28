#!/bin/sh
# -*- mode: shell-script -*-

# define useful variables
sysresources="/etc/X11/xinit/.Xresources"
sysmodmap="/etc/X11/xinit/.Xmodmap"
userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"

# merge in defaults and keymaps
if [ -f "$sysresources" ]; then
  if [ -x /usr/bin/cpp ] ; then
    xrdb -merge "$sysresources"
  else
    xrdb -nocpp -merge "$sysresources"
  fi
fi

if [ -f "$sysmodmap" ]; then
  xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
  if [ -x /usr/bin/cpp ] ; then
    xrdb -merge "$userresources"
  else
    xrdb -nocpp -merge "$userresources"
  fi
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d "/etc/X11/xinit/xinitrc.d" ] ; then
  for filename in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$filename" ] && . "$filename"
  done
  unset filename
fi

# start user's X programs
feh-background &
xss-lock --transfer-sleep-lock -- i3lock-wrapper &
unclutter --timeout 1 &
xset s off
xset -dpms

# launch i3
exec i3
