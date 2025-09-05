#!/bin/bash

/usr/bin/mcrcon -H localhost -P 25575 -p localhost "say Server stopping in 1 minute..."
sleep 30

/usr/bin/mcrcon -H localhost -P 25575 -p localhost "say Server stopping in 30 seconds..."
sleep 27

for i in {3..1}; do
  /usr/bin/mcrcon -H localhost -P 25575 -p localhost "say Server stopping in $i seconds..."
  sleep 1
done

/usr/bin/mcrcon -H localhost -P 25575 -p localhost save-all stop