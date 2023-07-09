#!/usr/bin/env bash
####################
set -e
####################
get_env(){
  ./scripts/get_env_var.sh .env ${1}
}
set_scripts_permissions(){
  chmod +x ./containers/eps/volume/scripts/*.sh
  chmod +x ./scripts/*.sh
}
copy_dotenv(){
  if [ -e .env ]; then return 0; fi
  cp .env.example .env
}
setup_network(){
  if ! docker network ls | awk '{print $2}' | grep '^bitcoin$' > /dev/null; then
    docker network create -d bridge bitcoin
  fi
}
build(){
  docker-compose build \
    --build-arg CONTAINER_USER=${USER} \
    --build-arg CONTAINER_UID=$(id -u) \
    --build-arg CONTAINER_GID=$(id -g) \
    --build-arg $(get_env 'BITCOIN_USER') \
    --build-arg $(get_env 'BITCOIN_PASSWORD') \
    --build-arg $(get_env 'BITCOIN_HOSTNAME') \
    --build-arg $(get_env 'BITCOIN_PORT')
}
ignite(){
  docker-compose up \
    --remove-orphans &
}
####################
up(){
  set_scripts_permissions
  copy_dotenv
  setup_network
  #  build
  ignite
}
down(){
  docker-compose down
}
clean(){
  printf "Are you sure? (Y/n): "
  read input
  case $input in
    Y)
      rm -rf ./containers/eps/volume/data 2>&1 || true
    ;;
    *) printf '\nAbort.' ;;    
  esac
  
}
add_wallet(){
  docker exec -it eps su - -c "/app/scripts/add_wallet.sh '${1}'" ${USER}
}
####################
case ${1} in 
  up) up ;;
  down) down ;;
  add_wallet) add_wallet "${2}" ;;
  *) printf 'Usage: [ add_wallet | up | down | help ]\n' 1>&2; exit 1 ;;
esac
