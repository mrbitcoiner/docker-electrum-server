FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG CONTAINER_USER
ARG CONTAINER_UID
ARG CONTAINER_GID
ARG BITCOIN_USER
ARG BITCOIN_PASSWORD
ARG BITCOIN_HOSTNAME
ARG BITCOIN_PORT
ARG BITCOIN_WALLET
ARG RESCAN_MODE

ENV CONTAINER_USER=${CONTAINER_USER}
ENV CONTAINER_UID=${CONTAINER_UID}
ENV CONTAINER_GID=${CONTAINER_GID}
ENV BITCOIN_USER=${BITCOIN_USER}
ENV BITCOIN_PASSWORD=${BITCOIN_PASSWORD}
ENV BITCOIN_HOSTNAME=${BITCOIN_HOSTNAME}
ENV BITCOIN_PORT=${BITCOIN_PORT}
ENV BITCOIN_WALLET=${BITCOIN_WALLET}
ENV RESCAN_MODE=${RESCAN_MODE}

ADD ./volume/scripts/user_setup.sh /scripts/user_setup.sh
ADD ./volume/scripts/eps_install.sh /scripts/eps_install.sh

RUN echo "v0.1.0" > /version; \
  apt update && apt upgrade -y; \
  apt install -y tor python3-pip git; \
  /scripts/user_setup.sh ${CONTAINER_USER} ${CONTAINER_UID} ${CONTAINER_GID}; \
  su -c '/scripts/eps_install.sh' ${CONTAINER_USER}

ADD ./volume/scripts/init.sh /scripts/init.sh

ENTRYPOINT ["/scripts/init.sh"] 
