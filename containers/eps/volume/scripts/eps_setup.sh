#!/usr/bin/env bash
####################
set -e
####################
readonly EPS_DATA_DIR='/app/data/eps'
readonly SAMPLE="${HOME}/eps/repo/config.ini_sample"
readonly MPKS_FILE="${EPS_DATA_DIR}/mpks.txt"
readonly CONFIG_FILE="${EPS_DATA_DIR}/config.ini"
readonly EPS_CERTS_PATH="/app/data/certs/eps"
####################
mkdirs(){
  if [ -e ${EPS_DATA_DIR} ]; then return 0; fi
  mkdir -p ${EPS_DATA_DIR}
}
gen_certs(){
  if [ -e ${EPS_CERTS_PATH} ]; then return 0; fi 
  mkdir -p ${EPS_CERTS_PATH}
  cd ${EPS_CERTS_PATH}
  openssl req -nodes -newkey rsa:2048 -keyout server.key -out server.csr -subj "/C=NA/ST=NA/L=NA/O=NA/OU=NA/CN=NA"
  openssl x509 -req -days 1825 -in server.csr -signkey server.key -out server.crt
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
  if ! [ -e "${MPKS_FILE}" ]; then
    printf 'Master public keys file not found, add your master public keys and restart the service\n' 1>&2;
    printf 'Run ./control.sh to get the available options\n' 1>&2;

    while true; do sleep 60; done; fi
  local wallets="$(cat ${MPKS_FILE})"
  append_to_master_public_keys_section "${wallets}"
}
setup(){
  mkdirs
  gen_certs
  copy_eps_config_sample
  /app/scripts/custom_eps_config.sh
  restore_mkps
}
####################
setup
