#!/usr/bin/env bash
####################
set -e
####################
start_tor(){
  /app/scripts/tor_setup.sh
}
setup_eps(){
  su -c '/app/scripts/eps_setup.sh' ${CONTAINER_USER}
}
start_eps(){
  su -c '/app/scripts/eps_start.sh' ${CONTAINER_USER}
}
init(){
  start_tor
  setup_eps
  start_eps
}
####################
init
