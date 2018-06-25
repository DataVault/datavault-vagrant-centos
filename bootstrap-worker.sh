#!/usr/bin/env bash

export DATAVAULT_HOME=/datavault-home
export RABBIT_SERVER=rds-dv-mq-test.is.ed.ac.uk


# Java (Should be Openjre version 8)
yum -y install java-1.8.0-openjdk

# set the ip of the rabbit server
sed -i.bak "s/queue.server = localhost/queue.server = $RABBIT_SERVER/" $DATAVAULT_HOME/config/datavault.properties


# Start the Worker(s)

chmod 777 $DATAVAULT_HOME/bin/start-worker.sh
$DATAVAULT_HOME/bin/start-worker.sh >> /tmp/worker.log

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
