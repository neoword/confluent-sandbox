#!/bin/bash
NODE_ID=`vagrant global-status | grep node2 | awk '{print $1}'`

# submit the job
# TODO - add arg checking to ensure the component is supported
vagrant ssh ${NODE_ID} -c "/home/vagrant/scripts/submit.sh $1"
