#!/bin/bash

# Make sure this script is in /home/vagrant/jobs/submit_zk.sh
#
# Execute this script by doing the following:
# vagrant ssh node2 -c /home/vagrant/jobs/submit_zk.sh
NOMAD_ADDR="http://192.168.33.11:4646" nomad job run /home/vagrant/jobs/zookeeper.hcl
