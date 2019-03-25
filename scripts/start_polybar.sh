#!/bin/env sh
pkill polybar
sleep 1;

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload i3wmthemer_bar &
    if [ $m == "HDMI-1" ]
    then
        ln -s /tmp/polybar_mqueue.$! /tmp/ipc-bottom
    fi
  done
else
  polybar --reload i3wmthemer_bar &
fi

