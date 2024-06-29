#!/usr/bin/env bash

polybar-msq cmd quit

# Launch default bar
if type "xrandr"; then
  for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi

echo "Bar launched..."
