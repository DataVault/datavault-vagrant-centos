#!/usr/bin/env bash


# Install Mysql
yum -y install mariadb-server 
service mariadb start
mysqladmin password "datavault"


# todo : insert something here to edit the Mysql char set

# listen to remote connections
echo >> /etc/my.cnf << EOF
[mysql]
/var/lib/mysql/db.err
EOF
service mariadb restart


# Create the database
cat /vagrant/datavault_database_create.sql | mysql -u root -pdatavault

