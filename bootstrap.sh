#!/bin/bash
#
# Install Puppet on the node

PATH=/bin:/usr/bin/

# Arguments from Vagrant
LSBDISTCODENAME=$1
FQDN=$2
HOST=`echo $FQDN|cut -d "." -f 1`

cd ~
wget https://apt.puppetlabs.com/puppetlabs-release-$LSBDISTCODENAME.deb
sudo dpkg -i puppetlabs-release-$LSBDISTCODENAME.deb
sudo apt-get update
sudo apt-get -y install puppet facter

sudo hostname $FQDN
sudo echo $FQDN > /etc/hostname
