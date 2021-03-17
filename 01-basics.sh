#! /bin/bash


# 1. Line Comment
# syntax error


# 2. Multi-line comment
: '
This is a comment
And so is this
This is the last commented line if you end it with a single quote '


# 3. heredoc
cat << someComment
Hello, this is some here document
passed onto cat
someComment


# 4. Printing to screen
echo Hello Basher


# 5. Variable Declaration, strictly no space around the equal sign
var1=10
echo "5. Variable Declaration: $var1"

