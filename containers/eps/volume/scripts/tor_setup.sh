#!/usr/bin/env bash
####################
set -e
####################
readonly HIDDEN_SERVICE_PATH='/app/data/tor/eps'
readonly EPS_PORT=50002
####################
set_config(){
  if grep "${HIDDEN_SERVICE_PATH}" /etc/tor/torrc > /dev/null; then return 0; fi
  cat << EOF >> /etc/tor/torrc
HiddenServiceDir ${HIDDEN_SERVICE_PATH}
HiddenServicePort ${EPS_PORT} 127.0.0.1:${EPS_PORT}
EOF
}
run(){
  su -c 'tor > /dev/null &' ${CONTAINER_USER}
  su -c "while ! [ -e ${HIDDEN_SERVICE_PATH}/hostname ]; do sleep 1; done" ${CONTAINER_USER}
}
setup(){
  set_config
  run
}
####################
setup
