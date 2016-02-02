# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.provision :shell, path: "install-zookeeper.sh"
  config.vm.provision :shell, path: "localhost-lag.sh", run: "always", :args => "100msec"
  config.vm.provision :shell, path: "zookeeper-init-ensemble.sh", run: "always", privileged: false

  config.vm.network "public_network"
end
