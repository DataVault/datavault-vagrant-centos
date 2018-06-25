#!/usr/bin/env bash

export DATAVAULT_HOME=/datavault-home

# Dependencies - Java (Should be Openjre version 8), tomcat, selinux policy utils.
yum -y install java-1.8.0-openjdk tomcat policycoreutils-python


# Set tomcat SELinux permissions for the datavault-home (or tomcat won't be allowed access)
semanage fcontext -a  -t pki_tomcat_etc_rw_t "$DATAVAULT_HOME(/.*)?"
restorecon -RF $DATAVAULT_HOME

# Change settings for address of rabbit and mysql servers
sed -i.bak 's/queue.server = localhost/queue.server = 192.168.0.12/' $DATAVAULT_HOME/config/datavault.properties
sed -i.bak2 's/localhost:3306/192.168.0.11:3306/' $DATAVAULT_HOME/config/datavault.properties

# cp /vagrant/envvars.sh /usr/share/tomcat/bin/setenv.sh # not used by CentOS tomcat version.
sed -i "s@webapps@$DATAVAULT_HOME/webapps@" /etc/tomcat/server.xml


# Set custom environment variables used by webapp
echo "DATAVAULT_HOME=$DATAVAULT_HOME" >> /etc/tomcat/tomcat.conf

service tomcat restart

# Directory for archive data (if using 'local storage')
mkdir -p /tmp/datavault/archive
# A temporary directory for workers to process files before storing in the archive
mkdir -p /tmp/datavault/temp
# A directory for storing archive metadata
mkdir -p /tmp/datavault/meta

