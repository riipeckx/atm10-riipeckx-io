#!/bin/bash

MCRCON_CMD="/usr/bin/mcrcon -H localhost -P 25575 -p localhost"

$MCRCON_CMD "say Server stopping in 1 minute..."
sleep 30

$MCRCON_CMD "say Server stopping in 30 seconds..."
sleep 27

for i in {3..1}; do
  $MCRCON_CMD "say Server stopping in $i seconds..."
  sleep 1
done

$MCRCON_CMD save-all stop