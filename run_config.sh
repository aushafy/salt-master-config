#!/bin/bash

# export dynamic ip address
export ip_address_node=$(ip a | grep eth0 | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" | head -1)

# run sed command that add configuration of interface using dynamic ip address that we add before
sudo sed -i -e "/0.0.0.0/a interface: $ip_address_node" -e '/4505/a publish_port: 4505' /etc/salt/master

# enable salt-master
sudo systemctl enable salt-master

# stop salt master
sudo systemctl stop salt-master

# run salt-master
sudo systemctl start salt-master
