#!/usr/bin/env bash

# Clause is not RegEx.
echo "Check for y* or else"
input="Yes"
case $input in
  [yY]* )
    echo "Affirmative!"
    ;;
  * ) echo "Unrecognized";;
esac
