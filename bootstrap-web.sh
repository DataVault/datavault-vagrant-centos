#!/usr/bin/env bash


# Dependencies - Java (Should be Openjre version 8), tomcat, selinux policy utils.
yum -y install java-1.8.0-openjdk tomcat policycoreutils-python


# Set tomcat SELinux permissions for the datavault-home (or tomcat won't be allowed access)
semanage fcontext -a  -t pki_tomcat_etc_rw_t "/vagrant_datavault-home(/.*)?"
restorecon -RF /vagrant_datavault-home

# Change settings for address of rabbit and mysql servers
sed -i.bak 's/queue.server = localhost/queue.server = 192.168.0.12/' /vagrant_datavault-home/config/datavault.properties
sed -i.bak2 's/localhost:3306/192.168.0.11:3306/' /vagrant_datavault-home/config/datavault.properties

# cp /vagrant/envvars.sh /usr/share/tomcat/bin/setenv.sh # not used by CentOS tomcat version.
cp -r /vagrant_datavault-home/webapps/* /usr/share/tomcat/webapps/
sed -i 's/webapps/\/vagrant_datavault-home\/webapps/' /etc/tomcat/server.xml


# Set custom environment variables used by webapp
echo "DATAVAULT_HOME=/vagrant_datavault-home" >> /etc/tomcat/tomcat.conf

service tomcat restart

