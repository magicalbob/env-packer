# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vagrant_config|
  vagrant_config.vm.define 'pipatwin01' do |srv|
    srv.vm.box = "windows"
  
    #srv.vm.provision "shell", path: "scripts/vbox.sh", privileged: true
    srv.vm.network "private_network", ip: "10.21.1.30"

    srv.vm.communicator = "winrm"
    srv.winrm.username = "vagrant"
    srv.winrm.password = "vagrant"
    srv.winrm.basic_auth_only = true
    srv.winrm.transport = "plaintext"
  
    srv.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
#      vb.customize ['createhd', '--filename', './extra_disk.vdi', '--size', 500 * 1024]
#      vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './extra_disk.vdi']
    end

  end

  vagrant_config.vm.define 'pipat-mobile-jenkins' do |srv|
    srv.vm.box = "centos7_pipat"
  
#    srv.vm.provision "shell", path: "scripts/vbox.sh", privileged: true
    srv.vm.network "private_network", ip: "10.21.1.25"
  
    srv.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end
end
