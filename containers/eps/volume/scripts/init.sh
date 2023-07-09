#!/usr/bin/env bash
####################
set -e
####################
tor_setup(){
  /app/scripts/tor_setup.sh
}
init(){
  tor_setup
  tail -f /dev/null
}
####################
init
