#!/bin/bash
# Ansible managed: /workspace/users/albandri10/env/ansible/roles/shell/templates/build.sh.j2 modified on 2014-11-08 19:51:40 by albandri on albandri-laptop-misys.misys.global.ad

DOCKERNAME="nabla/ansible-shell"

time docker build -t $DOCKERNAME .

echo
echo "This image is a trusted docker.io Image."
echo
echo "To pull it"
echo "    docker pull $DOCKERNAME"
echo
echo "To use this docker:"
echo "    docker run -d -P $DOCKERNAME"
echo
echo "To run in interactive mode for debug:"
echo "    docker run -t -i $DOCKERNAME bash"
echo
