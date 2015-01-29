# vagrant-files

A set of vagrant files for server deployments.

# Requirements

You will need a recent version of Vagrant. I suggest downloading the most recent 
official packages from Vagrant homepage:

* https://www.vagrantup.com/downloads.html

In addition you will need vagrant-aws and vagrant-env plugins:

* https://github.com/mitchellh/vagrant-aws
* https://github.com/gosuri/vagrant-env

The plugins can be installed easily:

    $ vagrant plugin install vagrant-aws
    $ vagrant plugin install vagrant-env

# Deploying to EC2

To use the EC2 wrapper do

    $ cd vagrant-files/ec2
    $ cp env.sample .env
    $ nano .env

Customize .env to your liking and then setup puppet.conf:

    $ cd ../synced
    $ cp puppet.conf.sample puppet.conf
    $ nano puppet.conf

Edit the puppet.conf to your liking and then just run

    $ FQDN=server.domain.com vagrant up

where FQDN is the fully-qualified domain name for the new node. The FQDN is 
primarily used to make sure that "facter fqdn" resolves to a reasonable value.
