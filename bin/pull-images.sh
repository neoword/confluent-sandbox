#!/bin/bash

# TODO - make this a bash loop over (node2 node3 node4)
NODE2_ID=`vagrant global-status | grep node2 | awk '{print $1}'`
vagrant ssh ${NODE2_ID} -c "docker pull confluentinc/cp-zookeeper:4.1.1-2"
vagrant ssh ${NODE2_ID} -c "docker pull confluentinc/cp-kafka:4.1.1-2"

NODE3_ID=`vagrant global-status | grep node3 | awk '{print $1}'`
vagrant ssh ${NODE3_ID} -c "docker pull confluentinc/cp-zookeeper:4.1.1-2"
vagrant ssh ${NODE3_ID} -c "docker pull confluentinc/cp-kafka:4.1.1-2"

NODE4_ID=`vagrant global-status | grep node4 | awk '{print $1}'`
vagrant ssh ${NODE4_ID} -c "docker pull confluentinc/cp-zookeeper:4.1.1-2"
vagrant ssh ${NODE4_ID} -c "docker pull confluentinc/cp-kafka:4.1.1-2"
