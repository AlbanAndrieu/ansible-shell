#!/bin/bash
#set -xve

if [ "$0" = "${BAHS_SOURCE[0]}" ]; then
  echo "This script has to be sourced and not executed..."
  exit 1
fi

WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# source only if terminal supports color, otherwise use unset color vars
# shellcheck source=/dev/null
source "${WORKING_DIR}/step-0-color.sh"

# shellcheck source=/dev/null
source "${WORKING_DIR}/step-1-os.sh"

# shellcheck source=/dev/null
source "${WORKING_DIR}/ansible-env.sh"

echo -e "${cyan} =========== ${NC}"
echo -e "${green} Ansible vault password. ${NC}"

if [ -c "${WORKING_DIR}/../vault.passwd" ]; then
  echo -e "${green} ${WORKING_DIR}/../vault.passwd exist ${happy_smiley} : *** ${NC}"
else
  echo -e "${cyan} No {WORKING_DIR}/../vault.passwd ${NC}"
  if [ -n "${ANSIBLE_VAULT_PASS}" ]; then
    echo -e "${green} ANSIBLE_VAULT_PASS is defined ${happy_smiley} : *** ${NC}"
    #echo "${ANSIBLE_VAULT_PASS}" > ${WORKING_DIR}/../vault.passwd || true
  else
    echo -e "${red} ${double_arrow} Undefined parameter ${head_skull} : ANSIBLE_VAULT_PASS ${NC}"
    #exit 1
  fi
fi

echo -e " ======= Running on ${TARGET_SLAVE} ${reverse_exclamation} ${NC}"
echo -e "USER : $USER ${NC}"
echo -e "HOME : $HOME ${NC}"
echo -e "WORKSPACE : $WORKSPACE ${NC}"

#tomcat8 must be stop to no use same port
#${USE_SUDO} service tomcat8 stop || true

echo -e "${cyan} =========== ${NC}"
echo -e "${green} Checking ansible version ${NC}"

# which ansible
if command -v "${ANSIBLE_CMD}" 2>&1 >/dev/null; then
  echo -e "${green} ansible found ${NC}"
  echo -e "${magenta} ANSIBLE_CMD : ${ANSIBLE_CMD} ${NC}"
  "${ANSIBLE_CMD}" --version | grep python || true
  RC=$?
  if [ ${RC} -ne 0 ]; then
    echo ""
    echo -e "${red} ${head_skull} Sorry, ansible basics failed ${NC}"
    exit 1
  fi
else
  echo -e "${red} ansible not found ${NC}"
fi

if command -v "${ANSIBLE_CMBD_CMD}"; then
  echo -e "${magenta} ANSIBLE_CMBD_CMD : ${ANSIBLE_CMBD_CMD} ${NC}"
  ${ANSIBLE_CMBD_CMD} --version || true
fi
if command -v "${ANSIBLE_GALAXY_CMD}"; then
  echo -e "${magenta} ANSIBLE_GALAXY_CMD : ${ANSIBLE_GALAXY_CMD} ${NC}"
  ${ANSIBLE_GALAXY_CMD} --version || true
fi

# shellcheck source=/dev/null
source "${WORKING_DIR}/run-ansible-setup.sh"

#exit 0
