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
  touch ${EPS_LOG}
}
run(){
  printf "Starting eps rescan\n"
  sleep 1
  ${EPS_PATH} --rescan ${CONFIG_FILE}
  export RESCAN_MODE=disabled
  /app/scripts/eps_start.sh
}
####################
mklog
run
