## [![Nabla](https://debops.org/images/debops-small.png)](https://github.com/AlbanAndrieu) alban_andrieu_shell

<!-- This file was generated by Ansigenome. Do not edit this file directly but
     instead have a look at the files in the ./meta/ directory. -->

[![Travis CI](https://img.shields.io/travis/AlbanAndrieu/ansible-shell.svg?style=flat)](https://travis-ci.org/AlbanAndrieu/ansible-shell)
[![Branch](http://img.shields.io/github/tag/AlbanAndrieu/ansible-shell.svg?style=flat-square)](https://github.com/AlbanAndrieu/ansible-shell/tree/master)
[![Donate](https://img.shields.io/gratipay/AlbanAndrieu.svg?style=flat)](https://www.gratipay.com/AlbanAndrieu)
[![test-suite](https://img.shields.io/badge/test--suite-ansible--alban__andrieu__shell-blue.svg?style=flat)](https://github.com/AlbanAndrieu/test-suite/tree/master/ansible-alban_andrieu_shell/)
[![Platforms](http://img.shields.io/badge/platforms-debian%20/%20ubuntu-lightgrey.svg?style=flat)](#)
[![Gittip](http://img.shields.io/gittip/alban.andrieu.svg)](https://www.gittip.com/alban.andrieu/)
[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=AlbanAndrieu&url=https://github.com/alban.andrieu/ansible-phpvirtualbox&title=Ansible Role: PhpVirtualbox&language=&tags=github&category=software)

This ``Personal`` role allows you to install and configure [Shell](http://fr.wikipedia.org/wiki/Shell_Unix)
which can be used to setup your global environement variables on hosts.


### Role dependencies

- `geerlingguy.git`
### Installation

This role requires at least Ansible `v2.1.1`. To install it, run:

Using `ansible-galaxy`:
```shell
$ ansible-galaxy install alban.andrieu.shell
```

Using `arm` ([Ansible Role Manager](https://github.com/mirskytech/ansible-role-manager/)):
```shell
$ arm install alban.andrieu.shell
```

Using `git`:
```shell
$ git clone https://github.com/alban.andrieu/ansible-eclipse.git
```

### Documentation

More information about `alban.andrieu.shell` can be found in the
[official alban.andrieu.shell documentation](https://docs.debops.org/en/latest/ansible/roles/ansible-shell/docs/).


### Role variables

List of default variables available in the inventory:

```YAML
shell_enabled: yes                       # Enable module
shell_bash_enabled: yes                  # Enable bash shell
shell_csh_enabled: no                    # Enable csh shell
shell_ksh_enabled: yes                   # Enable ksh shell
shell_cygwin_enabled: no                 # Enable cygwin

#do not activate locate with docker
shell_locate_enabled: no                 # Enable locate search feature
shell_history_enabled: yes               # Enable history bash tweek
shell_nano_enabled: yes                  # Enable nano syntax color
shell_vim_enabled: yes                   # Enable vim syntax color
shell_maven_enabled: no                 # Enable maven syntax color
shell_log4j_enabled: yes                 # Enable log4j
shell_rlogin_enabled: yes                # Enable rsh rlogin rexecd
shell_synapse_enabled: no                # Enable synapse config
shell_git_meld_enabled: yes              # Enable git meld (shell_git_configure_enabled must be enabled too)
shell_git_completion_enabled: yes        # Enable git completion
shell_git_configure_enabled: yes         # Enable git configuration

#user: 'albandri' #please override me
user: "{{ lookup('env','USER') }}"
shell_owner: "{{ user }}"
shell_group: "{{ shell_owner }}"
#home: '~' #please override me
home: "{{ lookup('env','HOME') }}"
shell_owner_home: "{{ home }}"
shell_default_version: "30"
shell_project_home: "/workspace/users"
shell_workspace_suffix: "nabla/env"
shell_workspace_env: "{{ shell_project_home }}/{{ shell_owner }}{{ shell_default_version }}/{{ shell_workspace_suffix }}"
shell_env_directory: "{{ shell_workspace_env }}/home"
shell_dir_tmp: "/tmp" # or override with "{{ tempdir.stdout }} in order to have be sure to download the file"

shell_nano_color_repository: "https://github.com/nanorc/nanorc.git"
shell_vim_color_repository: "https://github.com/klen/.vim.git"
shell_synapse_directory: "{{ shell_owner_home }}/.config/synapse"
shell_git_meld_directory: "/usr/local/bin"

shell_git: []
  # Additional properties: 'shell_git_machine, shell_git_login, shell_git_email, shell_git_password, shell_git_name, shell_git_path, shell_git_ssl, shell_git_meld_enabled, shell_git_editor'
  # - shell_git_machine: 'localhost',
  #   shell_git_login: '{{ user }}',
  #   shell_git_email: '{{ user }}@localhost',
  #   shell_git_password: 'microsoft',
  #   # Optional.
  #   shell_git_name: '{{ shell_git_login }}',
  #   shell_git_path: '/usr/bin',
  #   shell_git_ssl: false,
  #   shell_git_meld_enabled: yes,
  #   shell_git_editor: "vim",

rhosts_hosts:
  - "albandri"
  - "albandri-laptop-misys"

newrelic_license_key: "de35bf5d191ebb208d359b2cd24a60616a02b1f3"
newrelic_app_name: "Nabla Demo"

webpagetest_api_key: "A.01ea5a02081b6d10415d7b0e7c844e73"

docker_files_generated_directory: "./"
docker_files_enable: no
docker_volume_directory: "{{ shell_env_directory }}"
docker_working_directory: "/home/vagrant"
docker_image_name: "nabla/ansible-shell"
```


### Detailed usage guide

Run the following command :

`ansible-playbook -i hosts -c local -v shell.yml -vvvv --ask-sudo-pass | tee setup.log`


### Authors and license

`alban_andrieu_shell` role was written by:

- [Alban Andrieu](fr.linkedin.com/in/nabla/) | [e-mail](mailto:alban.andrieu@free.fr) | [Twitter](https://twitter.com/AlbanAndrieu) | [GitHub](https://github.com/AlbanAndrieu)

- License: [GPLv3](https://tldrlegal.com/license/gnu-general-public-license-v3-%28gpl-3%29)

Copyright (c) 2016 [Alban Andrieu](https://alban-andrieu.com/)

### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/AlbanAndrieu/ansible-shell/issues)!

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests and examples for any new or changed functionality.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

***

This role is part of the [Nabla](https://github.com/AlbanAndrieu) project.
README generated by [Ansigenome](https://github.com/nickjj/ansigenome/).
