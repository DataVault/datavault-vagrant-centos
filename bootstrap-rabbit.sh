#!/usr/bin/env bash

# See: https://www.rabbitmq.com/install-rpm.html
rpm --import https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
yum-config-manager --add-repo https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
yum -y install rabbitmq-server

chkconfig rabbitmq-server on
service rabbitmq-server start

# Configure RabbitMQ users
# In this example the password is 'datavault'
rabbitmqctl add_user datavault datavault
rabbitmqctl set_user_tags datavault administrator
rabbitmqctl set_permissions -p / datavault ".*" ".*" ".*"

