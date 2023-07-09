#!/usr/bin/env bash
####################
set -e
####################
readonly FILE_PATH="${1}"
readonly KEY="${2}"
####################
check_input(){
  if [ -z ${FILE_PATH} ] || [ -z ${KEY} ]; then printf 'Expected: [ FILE_PATH ] [ KEY ]\n' 1>&2; return 1; fi
}
get_env() {
  if ! [ -e ${FILE_PATH} ]; then printf "File ${FILE_PATH} not found\n" 1>&2; return 1; fi
  if ! grep "^${KEY}=.*$" ${FILE_PATH} > /dev/null; then printf "Key ${KEY} does not exist\n" 1>&2; return 1; fi
  printf "$(grep "^${KEY}=.*$" ${FILE_PATH})"
}
####################
check_input
get_env "${FILE_PATH}" "${KEY}"
