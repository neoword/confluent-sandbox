# confluent-sandbox

This repo works with a [nomad cluster](https://github.com/neoword/nomad-sandbox)
to deploy the confluent services for local development.

## Install

```
# start zookeeper
> vagrant ssh node2 -c /vagrant/scripts/start_zk.sh
```

## Shutdown

```
# stop zookeeper
> vagrant ssh node2 -c /vagrant/scripts/stop_zk.sh
```
