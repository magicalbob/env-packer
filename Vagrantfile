# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# Require YAML module
require 'yaml'

common=nil

# Read YAML hieradata/common.yaml file to get hosts list
begin
  common = YAML.load_file('hieradata/common.yaml')
rescue
  print "Cannot open hieradata/common.yaml\n"
  exit 2
end       

Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vagrant_config|
  common['hosts'].each do |host|
    vagrant_config.vm.define "#{host[0]}" do |srv|
      srv.vm.box = "#{host[1]['box']}"
  
      srv.vm.network "private_network", ip: "#{host[1]['ip']}"

      if host[1]['os'] == "windows"
        srv.vm.communicator = "winrm"
        srv.winrm.username = "vagrant"
        srv.winrm.password = "vagrant"
        srv.winrm.basic_auth_only = true
        srv.winrm.transport = "plaintext"
      end

      srv.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
      end
    end
  end
end
