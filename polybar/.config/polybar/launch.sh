#!/usr/bin/env bash

polybar-msq cmd quit

# Launch default bar
polybar example 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bar launched..."
