#!/usr/bin/env bash
####################
set -e
####################
readonly EPS_DATA_DIR='/app/data/eps'
readonly SAMPLE="${HOME}/eps/repo/config.ini_sample"
readonly MPKS_FILE="${EPS_DATA_DIR}/mpks.txt"
readonly CONFIG_FILE="${EPS_DATA_DIR}/config.ini"
####################
mkdirs(){
  if [ -e ${EPS_DATA_DIR} ]; then return 0; fi
  mkdir -p ${EPS_DATA_DIR}
}
copy_eps_config_sample(){
  cp ${SAMPLE} ${CONFIG_FILE} 
}
append_to_master_public_keys_section(){
  sed -i "/^\[master-public-keys\]$/a\\${1}" ${CONFIG_FILE}
}
add_to_mpks_file(){
  printf "${1}"'\\n' >> ${MPKS_FILE}
}
restore_mkps(){
  if ! [ -e "${MPKS_FILE}" ]; then printf 'Master public keys file not found, add your master public keys\n' 1>&2; return 1; fi
  local wallets="$(cat ${MPKS_FILE})"
  append_to_master_public_keys_section "${wallets}"
}
setup(){
  mkdirs
  copy_eps_config_sample
  /app/scripts/custom_eps_config.sh
  restore_mkps
}
####################
setup
