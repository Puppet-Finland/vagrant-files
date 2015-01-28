# vagrant-files

A set of vagrant files for server deployments.

# Requirements

You will need a recent version of Vagrant. I suggest downloading the most recent 
official packages from Vagrant homepage:

* https://www.vagrantup.com/downloads.html

In addition you will need vagrant-aws and vagrant-env plugins:

* https://github.com/mitchellh/vagrant-aws
* https://github.com/gosuri/vagrant-env

# Deploying to EC2

To use the EC2 wrapper do

    $ cd ec2
    $ cp env.sample .env

Then fill in the blanks in the .env file. Then just run

    $ FQDN=something LSBDISTCODENAME=something vagrant up 

where FQDN is the fully-qualified domain name for the new node used primarily to 
make sure that "facter fqdn" resolves to a reasonable value. The LSBDISTCODENAME 
is used to locate correct Puppetlabs apt repo package. Example usage:

    $ FQDN=server.domain.com LSBDISTCODENAME=trusty vagrant up

Make sure that the LSBDISTCODENAME matches the operating system of the host 
being created.
