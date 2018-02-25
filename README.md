andrewrothstein.bazel
=========
[![Build Status](https://travis-ci.org/andrewrothstein/ansible-bazel.svg?branch=master)](https://travis-ci.org/andrewrothstein/ansible-bazel)

Installs [Bazel](https://bazel.build/)

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.bazel
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
