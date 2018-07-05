#!/bin/bash
NOMAD_ADDR="http://192.168.33.11:4646" nomad job stop zookeeper
sleep 3
curl -X PUT "${NOMAD_ADDR}/v1/system/gc"
