#!/bin/bash

: "
This script waits for a stack to be ready to serve.

Usage:
  ./scriptname.sh <stack-name>

  @stack-name - the stack name, e.g. ec-api-dev-5-15-241-mt-3024-snapshot-3055
"


STACK_NAME=$1
ENDPOINT="$STACK_NAME-int.amaysim.net"

echo Endpoint: $ENDPOINT

ISOK=`curl -i -s https://${ENDPOINT}/ecgateway/owi/webservices_sec/ecgw_compass.cfc\?method\=getWsdlVersion --max-time 5 | head -1 | grep "200 OK" | wc -l`

COUNT=0
while [ $ISOK -eq 0 ]; do
  echo "Waiting on EC application for '$STACK_NAME' at ${ENDPOINT} ..."

  COUNT=$[$COUNT + 1]
  if [ $COUNT -gt 90 ]; then
    echo "Error: EC application startup timeout: '$STACK_NAME' at ${ENDPOINT}"
    exit 1;
  fi

  sleep 10
  ISOK=`curl -i -s https://${ENDPOINT}/ecgateway/owi/webservices_sec/ecgw_compass.cfc\?method\=getWsdlVersion --max-time 5 | head -1 | grep "200 OK" | wc -l`
done

echo "EC application started for: '$STACK_NAME' at ${ENDPOINT}"
