#!/bin/bash
#set -xv

WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=/dev/null
source "${WORKING_DIR}/step-0-color.sh"

# shellcheck disable=SC2154
echo -e "${magenta} Building TEST runtime image ${NC}"
# shellcheck disable=SC2154
#echo -e "${green} pip install docker-compose==1.25.5 ${NC}"

if [ -n "${DOCKER_BUILD_ARGS}" ]; then
  # shellcheck disable=SC2154
  echo -e "${green} DOCKER_BUILD_ARGS is defined ${happy_smiley} : ${DOCKER_BUILD_ARGS} ${NC}"
else
  # shellcheck disable=SC2154
  echo -e "${yellow} ${double_arrow} Undefined parameter ${head_skull} : DOCKER_BUILD_ARGS, use the default one ${NC}"
  export DOCKER_BUILD_ARGS="--pull --restart=on-failure:2 --memory 512mb --cpus=\"1.5\" --build-arg ANSIBLE_VAULT_PASS=${ANSIBLE_VAULT_PASS}  --no-cache "
  #export DOCKER_BUILD_ARGS="--build-arg --no-cache --squash"
  echo -e "${magenta} DOCKER_BUILD_ARGS : ${DOCKER_BUILD_ARGS} ${NC}"
fi

if [ -n "${CST_CONFIG}" ]; then
  # shellcheck disable=SC2154
  echo -e "${green} CST_CONFIG is defined ${happy_smiley} : ${CST_CONFIG} ${NC}"
else
  # shellcheck disable=SC2154
  echo -e "${yellow} ${double_arrow} Undefined parameter ${head_skull} : CST_CONFIG, use the default one ${NC}"
  export CST_CONFIG="docker/ubuntu20/config.yaml"
  #export CST_CONFIG="docker/centos7/config.yaml" # runtime image
  echo -e "${magenta} CST_CONFIG : ${CST_CONFIG} ${NC}"
fi

if [ -n "${DOCKER_NAME}" ]; then
  # shellcheck disable=SC2154
  echo -e "${green} DOCKER_NAME is defined ${happy_smiley} : ${DOCKER_NAME} ${NC}"
else
  # shellcheck disable=SC2154
  echo -e "${yellow} ${double_arrow} Undefined parameter ${head_skull} : DOCKER_NAME, use the default one ${NC}"
  export DOCKER_NAME=${DOCKER_NAME:-"ansible-jenkins-slave-docker"}
  echo -e "${magenta} DOCKER_NAME : ${DOCKER_NAME} with ${CST_CONFIG} ${NC}"
fi

if [ -n "${DOCKER_TAG}" ]; then
  # shellcheck disable=SC2154
  echo -e "${green} DOCKER_TAG is defined ${happy_smiley} : ${DOCKER_TAG} ${NC}"
else
  # shellcheck disable=SC2154
  echo -e "${yellow} ${double_arrow} Undefined parameter ${head_skull} : DOCKER_TAG, use the default one ${NC}"
  export DOCKER_TAG=${DOCKER_TAG:-"latest"}
  echo -e "${magenta} DOCKER_TAG : ${DOCKER_TAG} ${NC}"
fi

if [ -n "${DOCKER_FILE}" ]; then
  # shellcheck disable=SC2154
  echo -e "${green} DOCKER_FILE is defined ${happy_smiley} : ${DOCKER_FILE} ${NC}"
else
  # shellcheck disable=SC2154
  echo -e "${yellow} ${double_arrow} Undefined parameter ${head_skull} : DOCKER_FILE, use the default one ${NC}"
  export DOCKER_FILE="../docker/ubuntu24/Dockerfile"
  #export DOCKER_FILE="Dockerfile"
  echo -e "${magenta} DOCKER_FILE : ${DOCKER_FILE} ${NC}"
fi

#readonly DOCKER_REGISTRY=${DOCKER_REGISTRY:-"https://hub.docker.com/"}
export DOCKER_REGISTRY=${DOCKER_REGISTRY:-""}
readonly DOCKER_ORGANISATION=${DOCKER_ORGANISATION:-"nabla"}
readonly DOCKER_USERNAME=${DOCKER_USERNAME:-""}
export DOCKER_NAME=${DOCKER_NAME:-"ansible-jenkins-slave-docker"}
export DOCKER_TAG=${DOCKER_TAG:-"latest"}

# DOCKER
export DOCKER_CLIENT_TIMEOUT=240
export COMPOSE_HTTP_TIMEOUT=2000
# See https://stackoverflow.com/questions/64221861/an-error-failed-to-solve-with-frontend-dockerfile-v0
export DOCKER_BUILDKIT=0
export BUILDKIT_STEP_LOG_MAX_SIZE=50000000
export COMPOSE_DOCKER_CLI_BUILD=0

echo -e "${magenta} DOCKER_CLIENT_TIMEOUT : ${DOCKER_CLIENT_TIMEOUT} ${NC}"
echo -e "${magenta} COMPOSE_HTTP_TIMEOUT : ${COMPOSE_HTTP_TIMEOUT} ${NC}"
echo -e "${magenta} DOCKER_BUILDKIT : ${DOCKER_BUILDKIT} ${NC}"
