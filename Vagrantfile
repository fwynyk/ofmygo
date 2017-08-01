# PLEASE INSTALL THESE PLUGINS BEFORE `vagrant up`:
# - hostmanager: `vagrant plugin install vagrant-hostmanager`
# - salt:        `vagrant plugin install vagrant-salt`

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.hostmanager.enabled = true
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if vm.id
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end

  config.vm.define "Database" do |db|
    db.vm.hostname = "database"
    db.vm.provider "virtualbox" do |v|
      v.cpus = 1
      v.memory = 2048
    end
    db.vm.network "private_network", ip: "192.168.100.10"
    db.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion.yml"
      salt.run_highstate = true
      salt.colorize = true
      salt.verbose = true
      salt.log_level = 'info'
    end
  end

  config.vm.define "Webapp" do |web|
    web.vm.network :forwarded_port, guest: 8080, host: 8080
    web.vm.network "private_network", ip: "192.168.100.20"
    web.vm.hostname = "webapp"
    web.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion.yml"
      salt.run_highstate = true
      salt.colorize = true
      salt.verbose = true
      salt.log_level = 'info'
    end
  end

  config.vm.define "Monitoring" do |mon|
    mon.vm.network :forwarded_port, guest: 8080, host: 8081
    mon.vm.network "private_network", ip: "192.168.100.30"
    mon.vm.hostname = "monitoring"
    mon.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion.yml"
      salt.run_highstate = true
      salt.colorize = true
      salt.verbose = true
      salt.log_level = 'info'
    end
  end

end
