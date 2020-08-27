# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "rethinc-oss/baseimage-ubuntu-1804"
  config.vm.hostname = "iso-builder.localdev"
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".", "/vagrant"
end
