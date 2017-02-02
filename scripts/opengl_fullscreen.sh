#!/bin/bash
xdotool windowsize `wmctrl -l | grep OpenGL -m1 | cut -f1 -d\ ` 1680 1050
