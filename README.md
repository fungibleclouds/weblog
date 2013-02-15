# Start working in a rails project

	rails new weblob
	cd weblog
	git init
	git add .
	git commit -m "Initial"

# Install librarian

	gem install librarian

# Add its work directories to your gitignore

	echo cookbooks >> .gitignore
	echo tmp >> .gitignore

# Create the Librarian config file

	librarian-chef init

# Create a spot for vendored cookbooks

	mkdir cookbooks-src

# Clone rails-lastmile into vendored cookbooks
	
	git submodule add git://github.com/DanThiffault/rails-lastmile.git cookbooks-src/rails-lastmile

# Next setup your Cheffile (think Gemfile) with the following recipes

	cookbook 'build-essential'
	cookbook 'ruby_build',
	  :git => 'git://github.com/fnichol/chef-ruby_build.git', :ref => 'v0.6.2'
	cookbook 'rbenv',
	  :git => 'https://github.com/fnichol/chef-rbenv', :ref => '7d9b66f20d6edb786720b22919fd53e698fce12b'
	cookbook 'apt',
	  :git => 'https://github.com/opscode-cookbooks/apt'
	cookbook 'unicorn'
	cookbook  'nginx'
	cookbook  'runit'

# Update Gemfile

## make sure to use 

	gem 'unicorn'
	gem 'execjs'
	gem 'therubyracer', :platforms => :ruby
	
# Use in Vagrant

## Install the gem

	gem install vagrant

## Grab the 64-bit base box. This could take a while

	vagrant box add precise64 http://files.vagrantup.com/precise64.box

## Make sure you're in the application directory and create a Vagrantfile
	
	vagrant init precise64
	
## Start vagrant

	vagrant up

# Use in the cloud

## get ruby installed in the cloud

	sudo su
	curl -L https://gist.github.com/lvnilesh/4651580/raw/8593fe70e8216e092ab831ff28ab0a5bd18fe502/chef_solo_bootstrap.sh  | bash

	ssh-copy-id ubuntu@chefserver.cloudapp.net
	ssh ubuntu@chefserver.cloudapp.net 
	rsync -r . ubuntu@chefserver.cloudapp.net://home/ubuntu/proj-name
	

