#!/bin/bash

NODES='node2 node3 node4'
for node in ${NODES}; do
  NODE_ID=`vagrant global-status | grep ${node} | awk '{print $1}'`
  vagrant ssh ${NODE_ID} -c "docker pull confluentinc/cp-zookeeper:4.1.1-2"
  vagrant ssh ${NODE_ID} -c "docker pull confluentinc/cp-kafka:4.1.1-2"
done
