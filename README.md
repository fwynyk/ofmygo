# OFMYGO
######(OneFootball MySQL Go)

## Easy setup (for Debian/Ubuntu)
- Git clone "ofmygo"
```
$ git clone https://github.com/fwynyk/ofmygo.git
``` 

- Run "install-and-run.sh" 

```
$ cd ofmygo

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

