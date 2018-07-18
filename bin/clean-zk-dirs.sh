#!/bin/bash

NODES='node2 node3 node4'
for node in ${NODES}; do
  NODE_ID=`vagrant global-status | grep ${node} | awk '{print $1}'`
  vagrant ssh ${NODE_ID} -c "sudo rm -rf /opt/zookeeper"
done
