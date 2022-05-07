#!/bin/bash
#set -xve

WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=/dev/null
source "${WORKING_DIR}/ansible-env.sh"

# Forcing ansible cmd to use python3.8
#export PYTHON_MAJOR_VERSION=3.8

#sudo apt-get install python${PYTHON_MAJOR_VERSION}-dev || true

command -v "${PYTHON_CMD}" 2>&1 >/dev/null || {
  echo -e "Ansible | PYTHON_CMD not found in system PATH, please make sure that docker is installed ${NC}"
  echo -e "${red} ${head_skull} Sorry, python basics failed ${NC}"
  #exit 1
  # shellcheck source=/dev/null
  #source "${HOME}/run-python.sh"
  RC=$?
  if [ ${RC} -ne 0 ]; then
    echo ""
    echo -e "${red} ${head_skull} Sorry, python basics failed ${NC}"
    exit 1
  fi
}

echo -e "${green} Configure workstation ${NC}"

if [ -d "${WORKSPACE}/ansible-jenkins-slave-docker" ]; then
  cd "${WORKSPACE}/ansible-jenkins-slave-docker" || return
  if [ -f ${WORKSPACE}/ansible-jenkins-slave-docker/vault.passwd ]; then
    #Below workaround for ansible plugins in jenkins (vault not found)
    cp ansible.cfg vault.passwd ${WORKSPACE} || true
  fi
fi

if command -v "${ANSIBLE_GALAXY_CMD}"; then
  echo -e "${cyan} =========== ${NC}"
  echo -e "${green} Installing roles version ${NC}"
  echo -e "${magenta} ${ANSIBLE_GALAXY_CMD} install -r ${WORKING_DIR}/../requirements.yml -p ${WORKING_DIR}/../roles/ --ignore-errors --force ${NC}"
  ${ANSIBLE_GALAXY_CMD} install -r ${WORKING_DIR}/../requirements.yml -p ${WORKING_DIR}/../roles/ --ignore-errors --force
fi

export ANSIBLE_CONFIG=${WORKING_DIR}/../ansible.cfg
export PROFILE_TASKS_SORT_ORDER=none
export PROFILE_TASKS_TASK_OUTPUT_LIMIT=all

if command -v "${ANSIBLE_CMD}"; then
  echo -e "${cyan} =========== ${NC}"
  echo -e "${green} Display setup ${NC}"
  echo -e "${magenta} ${ANSIBLE_CMD} -m setup ${TARGET_SLAVE} -i ${WORKING_DIR}/../${ANSIBLE_INVENTORY} -vvvv ${NC}"
  ${ANSIBLE_CMD} -m setup ${TARGET_SLAVE} -i ${WORKING_DIR}/../${ANSIBLE_INVENTORY} -vvvv
  RC=$?
  if [ ${RC} -ne 0 ]; then
    echo ""
    echo -e "${red} ${head_skull} Sorry, ansible setup failed ${NC}"
    exit 1
  else
    echo -e "${green} The ansible setup check completed successfully. ${NC}"
  fi
fi
