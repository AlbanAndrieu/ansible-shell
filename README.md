# ansible-shell

A role for installing shell.


## Actions

- Ensures that shell is installed (using `apt`)


## Usage:
```
  - name: Install shell
    hosts: shell
    user: root
  #  connection: local
    
    roles:
      - shell      
```

## License

MIT
