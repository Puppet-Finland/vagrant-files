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

# Deploying to EC2

EC2 deployments depend on the Vagrant AWS plugin:

* https://github.com/mitchellh/vagrant-aws

It can be installed easily using

    $ vagrant plugin install vagrant-aws

To configure the EC2 wrapper do

    $ cd vagrant-files/ec2
    $ cp env.sample .env
    $ nano .env

Customize .env to your liking.

The bootstrapping scripts are located under "bootstrap" directory. Here's one 
example:

    bootstrap/
    ├── common
    │   ├── puppet.conf
    │   ├── openvpn.conf
    │   └── openvpn.pass
    ├── linux
    │   └── init.sh
    └── windows
        ├── init.bat
        ├── init.ps1
        └── openvpn.cer

Vagrant syncs the contents of "bootstrap/common" to the remote host. The 
"bootstrap/linux/init.sh" (shell) or "bootstrap/windows/init.ps1" (PowerShell) 
scripts will get added to EC2 user data and are run when the instance launches. 
The OSFAMILY environment variable will determine which script to run.

Once you're done setting up your deployment scripts run

    $ FQDN=server.domain.com vagrant up

where FQDN is the fully-qualified domain name for the new node. The FQDN is 
used for two things:

* To give a name for the VM instance
* To make sure that "facter fqdn" resolves to a reasonable value

Environment variables given in .env can be overridden on the command-line. For 
example:

    $ FQDN=server.domain.com AMI=ami-628cbc7f VOLUMESIZE=40 OSFAMILY=Windows vagrant up
