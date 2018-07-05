#!/bin/bash
NODE_ID=`vagrant global-status | grep node2 | awk '{print $1}'`

# submit the job
vagrant ssh ${NODE_ID} -c /home/vagrant/scripts/submit-zk.sh
