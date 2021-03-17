# 1. Defining a function.
function f1() {
	echo ef-one
}


# 2. Invoking the function and getting its result.
result=`f1`
echo $result


# 3. Accessing arguments
function f2() {
	echo "arg 1: $1, arg 2: $2"
}
result2=`f2 "a" 2`
echo $result2


: '
	Get Category Value. Reads my config.plist.
'
function getCV() {
	echo `osascript -e 'set config to load script file ((path to home folder as text) & "applescript:lib:config.scpt")' -e "getCategoryValue(\"$1\", \"$2\") of config"`
}

result3=`getCV "bss" "DB_NAME"`
echo $result3
