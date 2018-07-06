#!/bin/bash
NODE_ID=`vagrant global-status | grep node2 | awk '{print $1}'`

# shutdown zk
vagrant ssh ${NODE_ID} -c /home/vagrant/scripts/shutdown-zk.sh
