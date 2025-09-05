#!/bin/bash

for i in {10..1}; do
  /usr/bin/mcrcon -H localhost -P 25575 -p localhost "say Server stopping in $i..."
  sleep 1
done

/usr/bin/mcrcon -H localhost -P 25575 -p localhost "say Stopping server now..."
sleep 1
/usr/bin/mcrcon -H localhost -P 25575 -p localhost save-all stop