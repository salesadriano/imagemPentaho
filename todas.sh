#!/bin/bash
for tmp in $(find  /etl/ -name "*.kjb") 
do
    /pentaho/kitchen.sh -file:$tmp
done
