#!/bin/sh
input_file="gunicorn.conf.py"

# DEFAULT VALUE IF NO ENV VARIABLE IS DEFINED
GUN_WORKERS=${GUN_WORKERS:-2}
export GUN_WORKERS=$GUN_WORKERS

GUN_THREADS=${GUN_THREADS:-2}
export GUN_THREADS=$GUN_THREADS

GUN_LOGLEVEL=${GUN_LOGLEVEL:-"info"}
export GUN_LOGLEVEL=$GUN_LOGLEVEL

GUN_WORKER_CLASS=${GUN_WORKER_CLASS:-"sync"}
export GUN_WORKER_CLASS=$GUN_WORKER_CLASS

VARS=`printenv|grep "^GUN_.*"`

for VAR in $VARS; do
  KEY=`echo $VAR | awk -F"=" '{print $1}'`
  VAL=`echo $VAR | awk -F"=" '{print $2}'`
  sed -i "s#{"$KEY"}#"$VAL"#g" $input_file
done