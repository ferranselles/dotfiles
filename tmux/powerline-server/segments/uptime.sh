#!/usr/bin/env sh
# Prints the uptime.
UP=`uptime | grep -PZo "(?<=up )[^,]*"`
echo "up $UP"
