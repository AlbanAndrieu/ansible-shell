# ansible-shell

A role for installing shell.


## Actions

- Ensures that shell is installed (using `apt`)

Usage example
------------

    - name: Install shell
      hosts: shell
      user: root
    
      roles:
        - shell      

Requirements
------------

none

Dependencies
------------

none

License
-------

MIT
