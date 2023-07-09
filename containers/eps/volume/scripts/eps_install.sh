#!/usr/bin/env bash
####################
set -e
####################
readonly EPS_DATA='/app/data/eps'
readonly EPS_GIT_REPO='https://github.com/chris-belcher/electrum-personal-server'
readonly EPS_COMMIT_VERSION='c28a90f366039bc23a01a048348c0cee84b710c4'
####################
check(){
  if which electrum-personal-server; then exit 0; fi
  mkdir -p ${EPS_DATA}
}
clone(){
  git clone ${EPS_GIT_REPO} ${EPS_DATA}/repo
  cd ${EPS_DATA}/repo && \
  git checkout ${EPS_COMMIT_VERSION}
}
install(){
  cd ${EPS_DATA}/repo && \
    pip3 install --user .
}
setup(){
  check
  clone
  install
}
####################
setup

