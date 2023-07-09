#!/usr/bin/env bash
####################
set -e
####################
readonly EPS_DATA='/app/data/eps'
readonly MPKS_FILE="${EPS_DATA}/mpks.txt"
readonly MPKS_BKP_FILE="${EPS_DATA}/mpks.txt.bak"
####################
mkdirs(){
  if [ -e ${EPS_DATA} ]; then return 0; fi
  mkdir -p ${EPS_DATA}
}
backup_if_file_exists(){
  if ! [ -e ${MPKS_FILE} ]; then return 0; fi
  cp ${MPKS_FILE} ${MPKS_BKP_FILE}
}
concatenate(){
  if [ -z "${1}" ] || echo "${1}" | grep '^help$' > /dev/null; then 
    printf "Usage examples:
    \'WATCH_ONLY_1 = zpubxxxxxxx\' 
    \'WATCH_ONLY_2 = 3 zpubxxxxxxx zpubyyyyyyy zpubzzzzzzz\'\n"
    return 1
  fi
  printf "${1}"'\\n' >> ${MPKS_FILE}
}
add_wallet(){
  local input="${1}"
  mkdirs
  backup_if_file_exists
  concatenate "${input}"
}
####################
add_wallet "${1}"
