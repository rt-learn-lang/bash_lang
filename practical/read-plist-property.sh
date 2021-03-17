#!/bin/bash

osascript -e 'set config to load script file ((path to home folder as text) & "applescript:lib:config.scpt")'
WORK=`osascript -e 'getCategoryValue("work", "Work Profile") of config'`

echo "Work: $WORK"
