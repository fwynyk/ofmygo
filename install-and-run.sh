#!/bin/bash

# NOTE: This script removes previous virtualbox installations!

# INSTALL VIRTUALBOX
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" >> /etc/apt/sources.list.d/virtualbox.list'

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get update

sudo apt remove virtualbox virtualbox-5.0 virtualbox-4.*

sudo apt-get install virtualbox-5.1


# INSTALL VAGRANT
curl -o- https://releases.hashicorp.com/vagrant/1.9.7/vagrant_1.9.7_x86_64.deb | sudo dpkg -i

# INSTALL VAGRANT PLUGIN DEPENDENCIES
sudo vagrant plugin install vagrant-hostmanager
sudo vagrant plugin install vagrant-salt

# RUN VAGRANT
vagrant up



