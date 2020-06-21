# centos-ide

A vagrant build for standing up a VM that can be used for devops activities.

Installs various compilers/interpreters

* openjdk
* go
* python3
* gcc
* ruby

as well as deployment tools

* docker
* ansible
* git
* pyenv

As part of the bootstrap process.

## Usage

Install vagrant / virtualbox on your host system.

Edit `centos-ide-vars.yml` as desired. Enable/Disable one of the IDE boxes should you wish. Redefine the following vars for git config tasks:

```
git_config_user
git_config_email
```

If you cloned this repo separately from the folder on your host where you wish to work, then move the following files to your desired directory.

```
Vagrantfile
bootstrap.sh
centos-ide-var.yml
```

And run the following command

```
vagrant up
```

## TODO

* More elegant vars
