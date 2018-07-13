#!/bin/bash
if [ $1 == "zk" ]; then
  JOB="zookeeper";
else
  JOB=$1;
fi
NOMAD_ADDR="http://192.168.33.11:4646" nomad job stop -purge ${JOB}
