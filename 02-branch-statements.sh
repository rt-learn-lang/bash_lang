#! /bin/bash


: '
Comparison Operators
= or == is equal to
!= is not equal to
< is less than in ASCII alphabetical order
> is greater than in ASCII alphabetical order
-z test that the string is empty (null)
-n test that a string is not null'



# 1. if statement, space after and before the wrapping square-brackets is required.
var1=10
if [ $var1 -eq 10 ]
then
	echo "1. if statement then"
fi


# 2. if-else statement
var1=10
if [ $var1 -eq 9 ]
then
	echo "2. if statement: the condition is true"
else
	echo "2. if-else statement: the condition is false"
fi


# 3. if-then with reduced new line format.
if [ $STATUS == "CREATE_COMPLETE" ]; then
  echo "Stack '$STACK_NAME' is running"
else
  echo "ERROR: Stack Name & Status: $STACK_NAME ${STATUS}"
  exit 1
fi


