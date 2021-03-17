#!/bin/bash

# 1. Quotes are optional if there are no space characters.
var1=dog
echo "1. Declaring a string variable"


: '
String test operators
= or == is equal to
!= is not equal to
< is less than in ASCII alphabetical order
> is greater than in ASCII alphabetical order
-z test that the string is empty (null)
-n test that a string is not null'

# 2. Check if string is null
if [ -z $var2 ]; then
	echo "2. Check if string is null/empty"
fi


var3="Not Empty"
# 4. Check if string is not null/empty
if [ -n "$var3" ]; then
	echo "3. Check if string is not null/empty"
fi
