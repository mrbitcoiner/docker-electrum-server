#!/usr/bin/env bash
####################
set -e
####################
readonly CONFIG_FILE="/app/data/eps/config.ini"
readonly EPS_PATH="/home/debian/.local/bin/electrum-personal-server"
readonly TOR_HOSTNAME="$(cat /app/data/tor/eps/hostname)"
readonly EPS_PORT=50002
readonly EPS_LOG='/tmp/electrumpersonalserver.log' 
####################
mklog(){
  tor ${EPS_LOG}
}
start(){
  printf "\nStarting electrum server at ${TOR_HOSTNAME}:50002\n"
  sleep 5
  tail -f ${EPS_LOG} &
  ${EPS_PATH} ${CONFIG_FILE} > /dev/null
}
####################
start
