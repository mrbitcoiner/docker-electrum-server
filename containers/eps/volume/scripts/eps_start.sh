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
  case ${1} in 
    enabled) 
      printf "\nStarting electrum server in rescan mode\n"
      printf "You should manually call the rescan command (./control.sh rescan)\n"
      while true; do sleep 60; done
    ;;
    disabled)
      printf "\nStarting electrum server at ${TOR_HOSTNAME}:50002\n"
      sleep 10
      tail -f ${EPS_LOG} &
      ${EPS_PATH} ${CONFIG_FILE} > /dev/null
    ;;
    *) printf "ENV VAR EPS_RESCAN, expected: [ enabled ] [ disabled ], got: ${1}\n" 1>&2; return 1 ;;
  esac
}
####################
mklog
run ${RESCAN_MODE}
