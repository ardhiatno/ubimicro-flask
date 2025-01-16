#!/bin/sh

/usr/bin/bash replacer.sh
python3 -m gunicorn --config gunicorn.conf.py --user app --group app