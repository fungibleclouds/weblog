# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rbconfig'
IS_WINDOWS = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/) ? true : false

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 8080     # internal port 80 => host port 8080
  config.vm.forward_port 3000, 3000

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
  config.vm.share_folder "proj-name", "/home/vagrant/proj-name", ".", :nfs => !IS_WINDOWS 

  # Allows symlinks to be created in the shared folder.
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/proj-name", "1"]

  # Increase the memory available the VM.
  config.vm.customize ["modifyvm", :id, "--memory", 4096]

  # Requires vagrant-vbguest plugin
  config.vbguest.auto_update = true


  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.
  #
#  config.vm.provision :chef_solo do |chef|
#
#    chef.cookbooks_path = ["cookbooks","cookbooks-src"]
#
#    chef.add_recipe "rails-lastmile"
#    chef.json = {
#      'rails-lastmile' => {
#         'app_dir' => '/home/vagrant/proj-name',
#         'ruby_version' => '1.9.3-p385'
#      }
#    }
#
#  end

  config.vm.provision :chef_client do |chef|
    chef.chef_server_url = "http://chefserver.cloudapp.net:4000"
    chef.validation_key_path = "~/.chef/validation.pem"
    chef.validation_client_name = "chef-validator"
    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "rbenv"
    chef.add_recipe "ruby_build"
    chef.add_recipe "nginx"
    chef.add_recipe "unicorn"
    chef.add_recipe "runit"
    chef.add_recipe "ohai"

    chef.add_recipe "rails-lastmile"
    chef.json = {
      'rails-lastmile' => {
      'app_dir' => '/home/vagrant/proj-name',
      'ruby_version' => '1.9.3-p385'
      }
    }
  end
end
