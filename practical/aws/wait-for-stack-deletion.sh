#!/bin/bash

: '
Usage:
  ./scriptname.sh <stack-name>

  @stack-name - name of the stack to be deleted.
'

STACK_NAME=$1

if [ -z $STACK_NAME ]; then
  echo Usage:
  echo "./wait-for-s.sh <stack-name>"

  exit 3;
fi

echo "Checking if stack is still alive: $STACK_NAME"

STACKS=`aws cloudformation describe-stacks | jq -r " .Stacks[] | .StackName" | grep "$STACK_NAME" | wc -l`

COUNT=0;
while [ $STACKS -gt 0 ]; do
  echo "Waiting for stack '$STACK_NAME' to be deleted ... "
  sleep 10;

  COUNT=$[$COUNT + 1]
  if [ $COUNT -gt 60 ]; then
    echo "Error: Delete Stack timeout: $STACK_NAME"
    exit 3;
  fi

  STACKS=`aws cloudformation describe-stacks | jq -r " .Stacks[] | .StackName" | grep "$STACK_NAME" | wc -l`
done;

echo "Stack '$STACK_NAME' Deleted."

# Might be better to handle this in the AppleScript given I can't even see the stack name in the notification due to the length of the notice text.
# osascript -e "display notification with title \"AppleScript\" subtitle \"Stack deleted: $STACK_NAME\" sound name \"Glass\""
