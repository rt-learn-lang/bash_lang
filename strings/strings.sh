#!/usr/bin/env bash

# 1. Initialize a string variable
string1="1. Hello"
echo $string1


# 2. String concatenation
string2a="a"
string2b="b"
string2c=$string2a$string2b
echo $string2c

# 3. String append
string3="3a"
string3+="z"
echo $string3


# 4. Print a newline
printf "\nPrinting newline before and after\n\n"


# 1. Tests an undefined variable
if [ -z  $undefined ]; then  # Checks if the variable is undefined,
    echo "It is empty"
else
    echo "It is not empty"
fi

empty=""
# 2. Tests an empty variable
if [ -z  $empty ]; then  # Checks if the variable is empty,
	echo "It is empty"
else
    echo "It is not empty"
fi


defined="Hello"
# 3. Tests a defined variable
if [ -z  $defined ]; then  # Checks if the variable is defined,
    echo "It is $defined"
else
    echo "It is not empty"
fi


# 4. String Length
var4="How Long?"
size=${#var4}
echo "Size of '$var4' is $size"

