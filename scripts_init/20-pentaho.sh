#!/bin/bash
wget -O pentaho.zip https://sourceforge.net/projects/pentaho/files/latest/download
unzip pentaho.zip
mkdir /pentaho
mv data-integration/* pentaho/
rm -Rf data-integration pentaho.zip
rsync /code/drivers/* /pentaho/lib/
    