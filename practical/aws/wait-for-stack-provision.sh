#!/bin/bash


: "
This script waits for the creation of a stack for a given ticket id.
IMPORTANT: It requires that you have active session via assume-role. If you
  don't, it will not give any error leaving you waiting for nothing.

Note: For Team City, sleep first for about 5 minutes before triggering this
script because that's how long before the build gets picked up.

Usage:
  ./scriptname.sh <ticket-id>

  @ticket-id - the JIRA ticket ID, e.g. MT-3070
"

TICKET_ID=`echo $1 | tr '[:upper:]' '[:lower:]'`

if [ -z $TICKET_ID ]; then
  echo "NOTE: Assume Role as needed."
  echo "Usage:"
  echo "./wait-for-stack-provision.sh <ticket-id>"

  exit 1
fi

# 1. Wait up to 10 minutes for stack to be provisioned.
STACK_NAME=`aws cloudformation describe-stacks | jq -r ' .Stacks[] | .StackName' | grep $TICKET_ID | grep ec-  | awk -F- '$10 < 6000 {print $0}' | sed '1q;d'`
COUNT=0
while [ -z $STACK_NAME ]
do
  echo "Waiting to provision the stack for ticket $TICKET_ID..."
  sleep 10
  COUNT=$[$COUNT + 1]
  if [ $COUNT -gt 60 ]; then
    echo "Error: Timeout on stack provision: $TICKET_ID"
    exit 1
  fi
  STACK_NAME=`aws cloudformation describe-stacks | jq -r ' .Stacks[] | .StackName' | grep $TICKET_ID | grep ec- | awk -F- '$10 < 6000 {print $0}' | sed '1q;d'`
done

echo "I found a stack: $STACK_NAME"

plutil -replace "bash-stack-name" -string "$STACK_NAME" ~/applescript/session.plist

echo "Result: $?"
