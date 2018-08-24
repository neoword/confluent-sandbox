#!/bin/bash

# TODO keep forloop of NODES for now... if not necessary in future, simplify to just 'node2'
NODES='node2'
CONFLUENT_VERSION='4.1.1-2'
for node in ${NODES}; do
  NODE_ID=`vagrant global-status | grep ${node} | awk '{print $1}'`
  vagrant ssh ${NODE_ID} -c "docker pull confluentinc/cp-zookeeper:${CONFLUENT_VERSION}"
  vagrant ssh ${NODE_ID} -c "docker pull confluentinc/cp-kafka:${CONFLUENT_VERSION}"
  if [[ "${node}" =~ "node2" ]]; then
    vagrant ssh ${NODE_ID} -c "docker pull confluentinc/cp-schema-registry:${CONFLUENT_VERSION}"
    vagrant ssh ${NODE_ID} -c "docker pull registry:2"
    CONFLUENT_IMAGES="cp-zookeeper:${CONFLUENT_VERSION} cp-kafka:${CONFLUENT_VERSION} cp-schema-registry:${CONFLUENT_VERSION}"
    for image in ${CONFLUENT_IMAGES}; do
      vagrant ssh ${NODE_ID} -c "docker tag confluentinc/${image} node2:5000/${image}"
      vagrant ssh ${NODE_ID} -c "docker push node2:5000/${image}"
    done
    vagrant ssh ${NODE_ID} -c "docker tag registry:2 node2:5000/registry:2"
    vagrant ssh ${NODE_ID} -c "docker push node2:5000/registry:2"
  fi
done
