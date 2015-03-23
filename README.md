# vagrant-files

A set of vagrant files for server deployments.

# Requirements

You will need a recent version of Vagrant. I suggest downloading the most recent 
official packages from Vagrant homepage:

* https://www.vagrantup.com/downloads.html

In addition you will need the vagrant-env plugin:

* https://github.com/gosuri/vagrant-env

It can be installed easily:

    $ vagrant plugin install vagrant-env

Bootstrapping scripts come from the PuppetFinland "scripts" repository:

* https://github.com/Puppet-Finland/scripts

They are included as a Git submodule.

# Configuring vagrant-files

To configure Vagrant do

    $ cd vagrant-files/vagrant
    $ cp env.sample .env
    $ nano .env

Customize .env to your liking - many of the parameters are provider-specific, so 
you don't need to fill in everything. All parameters can be overridden on the 
command-line. For example if you're using the EC2 provider you could do

    $ FQDN=server.domain.com AMI=ami-628cbc7f VOLUMESIZE=40 vagrant up

This would create an instance with differing volume size from a differing AMI 
image than what is configured in vagrant/.env.

You can also maintain several different env files for different purposes and 
make .env a symbolic link to the desired one. You may need to "rm -rf 
vagrant/.vagrant" after switching environments, though.

# EC2 notes

EC2 deployments depend on the Vagrant AWS plugin:

* https://github.com/mitchellh/vagrant-aws

It can be installed easily using

    $ vagrant plugin install vagrant-aws

The value of EC2_USER_DATA environment variable will determine the script to run 
on the host. All the other parameters are typical EC2 stuff.

# Libvirt notes

Libvirt deployments depend on the Vagrant libvirt plugin:

* https://github.com/pradels/vagrant-libvirt

It can be installed easily using

    $ vagrant plugin install vagrant-libvirt

# Deploying

Once you're done setting up your deployment scripts and .env file, run

    $ FQDN=server.domain.com vagrant up --provider <provider>

Where provider is "aws" (ec2) or "libvirt". FQDN is the fully-qualified domain 
name for the new node and it is used for two things:

* To give a name for the VM instance
* To make sure that "facter fqdn" resolves to a reasonable value

With *NIX provisioning things should just magically work. With Windows be 
prepared to endure tons of pain and sorrow.
