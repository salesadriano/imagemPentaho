#!/bin/bash
service ntp start
service cron start

crontab /cron.list

 tail -f /dev/null 