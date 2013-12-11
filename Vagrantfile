# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Install the latest Chef via vagrant-omnibus
  config.omnibus.chef_version = :latest

  # Unlike most of the stuff we're testing, logstash requires >1024M
  # of memory to even start up, so here we modify the memory size of
  # the VM in a VirtualBox-specific way (generally not recommended).
  config.vm.provider 'virtualbox' do |v|
    v.customize ['modifyvm', :id, '--memory', '4608']
  end

  config.vm.hostname = 'logserver-berkshelf'

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'precise64'

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = 'http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-amd64-disk1.box'

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: '33.33.33.9'

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

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
