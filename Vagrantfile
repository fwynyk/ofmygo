# PLEASE INSTALL THESE PLUGINS BEFORE `vagrant up`:
# - hostmanager: `vagrant plugin install vagrant-hostmanager`
# - salt:        `vagrant plugin install vagrant-salt`

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 2048
  end

  config.vm.network "private_network", type: "dhcp"
  
  config.hostmanager.enabled = true
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if vm.id
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end

  config.vm.synced_folder "salt/roots/", "/srv/salt/"

  config.vm.define "Database" do |db|
    db.vm.hostname = "mysqlserver"
    db.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion.yml"
      salt.run_highstate = true
      salt.colorize = true
      salt.log_level = 'info'
    end
  end
end
