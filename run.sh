#!/bin/bash
#set -xeuo pipefail
#IFS=$'\n\t'

set -x

echo "Stopping servers"
sudo service nginx stop
killall gunicorn

echo "Starting servers"
cd backend
set +x
source venv/bin/activate
set -x
gunicorn -w 2 -D --bind :8042 app:app
set +x
deactivate
set -x
cd ..

sudo service nginx start