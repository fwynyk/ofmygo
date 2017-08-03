# OFMYGO

OFMYGO (OneFootball MySQL Go) is a test lab which builds 3 Virtualbox servers using [vagrant](https://www.vagrantup.com/) and [saltstack](https://saltstack.com/). Each virtual machine runs a different service, as follows:

- 'Database', which runs MySQL 5.6
- 'Webapp', which runs a Go application called ['gowebapp'](https://github.com/josephspurrier/gowebapp)
- 'Monitoring', which runs Sensu server and monitors the 3 servers

You can choose to follow [Easy setup](#easy-setup-for-debianubuntu) or [Standard setup](#standard-setup), according with your needs.
 

## Easy setup (for Debian/Ubuntu)

##### NOTE: This script removes previous virtualbox installations! If you have any issues, please follow [Standard setup](#standard-setup).

Be aware that 'install-and-run.sh' will download [Vagrant](https://www.vagrantup.com/downloads.html) and [Virtualbox](https://www.virtualbox.org/wiki/Linux_Downloads) latest versions and associated dependencies. It also install some vagrant plugins and bring all virtual machines up in the end of the process. 

- Git clone "ofmygo"
```
$ git clone https://github.com/fwynyk/ofmygo.git
``` 

- Run "install-and-run.sh" 

```
$ cd ofmygo

$ chmod +x install-and-run.sh

$ ./install-and-run.sh
```


## Standard setup

- Make sure you have latest  versions of [Vagrant](https://www.vagrantup.com/downloads.html) and [Virtualbox](https://www.virtualbox.org/wiki/Linux_Downloads)  installed

- Install vagrant plugins

`$ sudo vagrant plugin install vagrant-hostmanager`

`$ sudo vagrant plugin install vagrant-salt`

- Git clone "ofmygo"

`$ git clone https://github.com/fwynyk/ofmygo.git` 

- Run vagrant

```
$ cd ofmygo

$ vagrant up
```

## Usage

To reach gowebapp, point your browser to:

`$ http://localhost:8080/`

To reach Sesu monitoring, point your browser to:

`$ http://localhost:8081/`

