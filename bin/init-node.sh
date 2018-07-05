#!/bin/bash
NODE_ID=`vagrant global-status | grep node2 | awk '{print $1}'`
OPTIONS=`vagrant ssh-config ${NODE_ID} | grep -v "Host " | awk -v ORS=' ' '{print "-o " $1 "=" $2}'`
vagrant ssh ${NODE_ID} -c "rm -rf scripts/ jobs/"
scp ${OPTIONS} -pr jobs/ 127.0.0.1:/home/vagrant/jobs/
scp ${OPTIONS} -pr scripts/ 127.0.0.1:/home/vagrant/scripts/
vagrant ssh ${NODE_ID} -c "chmod 755 /home/vagrant/scripts/*.sh"
