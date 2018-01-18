#!/usr/bin/env bash

# 1. Check for equality.
read -p "Your name? " name
if [[ $name = $USER ]]; then
    echo "Hello, me."
else
    echo "Hello, $name."
fi