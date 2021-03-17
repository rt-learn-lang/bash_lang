#!/bin/bash


: '
This script waits for the creation of a stack for a given ticket id.
It requires that you have active session via assume-role.


Usage:
	./scriptname.sh <ticket-id>

	@ticket-id - the JIRA ticket ID in lowercase e.g. mt-3070
'

TICKET_ID=$1

# 1. Wait for stack to be provisioned.
STACK_NAME=`aws cloudformation describe-stacks | jq -r ' .Stacks[] | .StackName' | grep $TICKET_ID | sed '1q;d'`
COUNT=0
while [ -z $STACK_NAME ]
do
  echo "Waiting to provision the stack for ticket $1..."
  sleep 10
  COUNT=$[$COUNT + 1]
  if [ $COUNT -gt 60 ]; then
    echo "Error: Timeout on stack provision: $1"
    exit 1
  fi
  STACK_NAME=`aws cloudformation describe-stacks | jq -r ' .Stacks[] | .StackName' | grep $TICKET_ID | sed '1q;d'`
done

echo "I found a stack: $STACK_NAME"


# 2. Wait for stack to exist
STATUS=`aws cloudformation describe-stacks --stack-name $STACK_NAME | jq -r " .Stacks[] | .StackStatus"`
COUNT=0
while [ -z $STATUS ] || [ $STATUS != "CREATE_COMPLETE" ]
do
  echo "Waiting on Stack '$STACK_NAME' to start up ..."
  sleep 10
  COUNT=$[$COUNT + 1]
  if [ $COUNT -gt 60 ]; then
    echo "Error: Timeout on Stack startup: $STACK_NAME"
    exit 1
  fi
  STATUS=`aws cloudformation describe-stacks --stack-name $STACK_NAME | jq -r " .Stacks[] | .StackStatus"`
done

echo "Status is: $STATUS"

if [ $STATUS == "CREATE_COMPLETE" ]; then
  echo "Stack '$STACK_NAME' is running"
else
  echo "ERROR: Stack Name & Status: $STACK_NAME ${STATUS}"
  exit 1
fi
