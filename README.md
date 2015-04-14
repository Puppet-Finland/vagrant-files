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

To configure Vagrant edit .env in a provider-specific directory, e.g.

    $ cd vagrant-files/ec2
    $ cp env.sample .env
    $ nano .env

Customize .env to match your environment. All of the parameters can be 
overridden on the command-line. For example if you're using the EC2 provider you 
could do

    $ FQDN=server.domain.com AMI=ami-628cbc7f VOLUMESIZE=40 vagrant up

This would create an instance with a volume size and AMI image that differ from
what is configured in ec2/.env.

You can also maintain several different env files for different purposes and 
make .env a symbolic link to the desired one. You may need to "rm -rf 
ec2/.vagrant" after switching environments, though.

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

Note that vagrant-libvirt does not currently support attaching the generated VM 
to an existing bridge interface. This makes it a bit less useful for production 
server deployments, but does not negatively affect the VirtualBox-style 
desktop/laptop test provisioning.

# Deploying

Once you're done setting up your deployment scripts and .env file, go to the 
provider-specific directory (e.g. "ec2" or "libvirt") and run

    $ FQDN=server.domain.com vagrant up

FQDN is the fully-qualified domain name for the new node and it is generally 
used for two things:

* To give a name for the VM instance
* To make sure that "facter fqdn" resolves to a reasonable value

Some of the puppet-specific example bootstrapping scripts also parse the 
LSBDISTCODENAME parameter, which is only used to determine which Puppet packages 
to install from Puppetlabs software repositories:

    $ FQDN=server.domain.com LSBDISTCODENAME=wheezy vagrant up

With *NIX provisioning and bootstrapping should just magically work. With 
Windows be prepared to endure tons of pain and sorrow.
