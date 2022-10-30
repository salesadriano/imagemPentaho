#!/bin/bash
for tmp in $(find  /code/etl/ -name "*.kjb") 
do
    /pentaho/kitchen.sh -file:$tmp
done

/pentaho/pan.sh -file:/etl/etlSafira/cargaSafira.ktr 