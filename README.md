ansible-shell
====================

A role for installing shell.

[![Build Status](https://api.travis-ci.org/AlbanAndrieu/ansible-shell.png?branch=master)](https://travis-ci.org/AlbanAndrieu/ansible-shell)
[![Galaxy](http://img.shields.io/badge/galaxy-shell-blue.svg?style=flat-square)](https://galaxy.ansible.com/list#/roles/0000)
[![Tag](http://img.shields.io/github/tag/AlbanAndrieu/ansible-shell.svg?style=flat-square)]()

## Actions

- Ensures that shell is installed (using `apt`)

Usage example
------------

```
  - name: Install shell
    hosts: shell
    remote_user: root
  #  connection: local

    vars_files:
      - [ "roles/shell/defaults/main.yml" ]  
      - [ "roles/shell/vars/default.yml" ]
      - [ "roles/shell/vars/version.yml" ]  
      - [ "roles/shell/vars/custom-{{ ansible_distribution }}-{{ ansible_architecture }}.yml", "roles/shell/vars/custom-{{ ansible_distribution }}.yml" ]  
        
    roles:
      - shell      
      
```

Requirements
------------

none

Dependencies
------------

none

License
-------

MIT

#### Feedback, bug-reports, requests, ...

Are 
[welcome](https://github.com/AlbanAndrieu/ansible-shell/issues)!
