#!/bin/bash
#set -xve

WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=./scripts/ansible-env.sh
source "${WORKING_DIR}/ansible-env.sh"

echo -e "${cyan} =========== ${NC}"
echo -e "${green} Ansible lint ${NC}"
echo -e "${magenta} ${ANSIBLE_LINT_CMD} -p ${WORKING_DIR}/../playbooks/${TARGET_PLAYBOOK} > ${WORKING_DIR}/../ansible-lint.txt ${NC}"
${ANSIBLE_LINT_CMD} -p ${WORKING_DIR}/../playbooks/${TARGET_PLAYBOOK} >${WORKING_DIR}/../ansible-lint.txt
echo -e "${magenta} ansible-lint-junit ${WORKING_DIR}/../ansible-lint.txt -o ${WORKING_DIR}/../ansible-lint.xml ${NC}"
ansible-lint-junit ${WORKING_DIR}/../ansible-lint.txt -o ${WORKING_DIR}/../ansible-lint.xml

exit 0
