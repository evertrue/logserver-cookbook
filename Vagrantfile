# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.customize ['modifyvm', :id, "--memory", "4608"]
  end

  config.vm.hostname = 'logserver-berkshelf'

  config.vm.box = "precise64"

  config.vm.box_url = "http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-amd64-disk1.box"

  config.vm.network :private_network, ip: "33.33.33.9"
  config.berkshelf.enabled = true

  config.vm.provision :shell, :inline => "curl -s -L https://www.opscode.com/chef/install.sh | sudo bash"

  config.vm.synced_folder "vagrantsync/", "/vagrantsync"

  if ENV['CHEF_REPO']
    chef_repo = ENV['CHEF_REPO']
  else
    fail 'CHEF_REPO is not defined'
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = { 'chef_env_long_name' => 'VAGRANT' }

    chef.data_bags_path = "#{chef_repo}/data_bags"
    chef.encrypted_data_bag_secret_key_path = "#{ENV['HOME']}/.chef/encrypted_data_bag_secret"

    chef.run_list = [
      'recipe[logserver::default]'
    ]
  end
end
