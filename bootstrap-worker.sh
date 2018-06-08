#!/usr/bin/env bash



# Java (Should be Openjre version 8)
yum -y install java-1.8.0-openjdk

# set the ip of the rabbit server
sed -i.bak 's/queue.server = localhost/queue.server = 192.168.0.12/' /vagrant_datavault-home/config/datavault.properties


# Start the Worker(s)
. /vagrant/envvars.sh
export DATAVAULT_HOME=/vagrant_datavault-home
chmod 777 /vagrant_datavault-home/bin/start-worker.sh
/vagrant_datavault-home/bin/start-worker.sh >> /tmp/worker.log

# Some dummy data (if using 'local storage')
#mkdir -p /Users
#touch /Users/file1
#touch /Users/dir1

# Directory for archive data (if using 'local storage')
mkdir -p /tmp/datavault/archive
# A temporary directory for workers to process files before storing in the archive
mkdir -p /tmp/datavault/temp
# A directory for storing archive metadata
mkdir -p /tmp/datavault/meta
