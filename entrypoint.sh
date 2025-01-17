#!/bin/sh

NCORE=$(( $(grep -c ^processor /proc/cpuinfo) + 1 ))
GUN_WORKERS=${GUN_WORKERS:-$NCORE}
export GUN_WORKERS=$GUN_WORKERS

python3 replacer.py
python3 -m gunicorn --config gunicorn.conf.py --user app --group app