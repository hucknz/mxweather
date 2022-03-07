#!/bin/bash
service nginx start

set -x
pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
    sleep 2
    cp -f /opt/CumulusMX/Cumulus.ini /opt/CumulusMX/config/
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
trap 'kill ${!}; term_handler' SIGTERM

# run application
cp -f /opt/CumulusMX/config/Cumulus.ini /opt/CumulusMX/
mono /opt/CumulusMX/CumulusMX.exe >> /var/log/nginx/CumulusMX.log &
pid="$!"

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done
