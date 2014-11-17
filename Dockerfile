# Ansible managed: /workspace/users/albandri10/env/ansible/roles/shell/templates/Dockerfile.j2 modified on 2014-11-08 19:51:40 by albandri on albandri-laptop-misys.misys.global.ad
#FROM        debian:jessie
#FROM        stackbrew/ubuntu:14.04
FROM        jasongiedymin/ansible-base-ubuntu

# Volume can be accessed outside of container
VOLUME      [/workspace/users/albandri10//env/home]

MAINTAINER  Alban Andrieu "https://github.com/AlbanAndrieu"

ENV			DEBIAN_FRONTEND noninteractive
ENV         WORKSPACE /workspace/users/albandri10//env/home

# Working dir
WORKDIR /home/vagrant

# COPY
#COPY /workspace/users/albandri10/env/ansible/roles/jenkins-slave $WORKDIR

# ADD
ADD defaults $WORKDIR/defaults
ADD meta $WORKDIR/meta
ADD files $WORKDIR/files
#ADD handlers $WORKDIR/handlers
ADD tasks $WORKDIR/tasks
ADD templates $WORKDIR/templates
ADD vars $WORKDIR/vars

# Here we continue to use add because
# there are a limited number of RUNs
# allowed.
ADD hosts /etc/ansible/hosts
ADD playbook.yml $WORKDIR/playbook.yml -vvvv

# Execute
RUN         ansible-playbook $WORKDIR/playbook.yml -i $WORKDIR/hosts -c local

EXPOSE      22
#ENTRYPOINT  ["/etc/init.d/jenkins-swarm-client"]
CMD /usr/sbin/sshd -D
#CMD ["-g", "deamon off;"]
