#!/bin/bash

NODES='node2 node3 node4'
VERSION='4.1.1-2'
for node in ${NODES}; do
  NODE_ID=`vagrant global-status | grep ${node} | awk '{print $1}'`
  vagrant ssh ${NODE_ID} -c "docker pull confluentinc/cp-zookeeper:${VERSION}"
  vagrant ssh ${NODE_ID} -c "docker pull confluentinc/cp-kafka:${VERSION}"
  if [[ "${node}" =~ "node2" ]]; then
    vagrant ssh ${NODE_ID} -c "docker pull confluentinc/cp-schema-registry:${VERSION}"
  fi
done
