# confluent-sandbox

This repo works with a [nomad cluster][17a16315] to deploy
[confluent][b9e4299d] services as [nomad jobs][501db49e] for local
development.

  [b9e4299d]: http://confluent.io "Confluent website"
  [501db49e]: https://www.nomadproject.io/ "Nomad Project"
  [17a16315]: https://github.com/neoword/nomad-sandbox "Nomad Sandbox"

## Setup node scripts

This is necessary only once to deploy the necessary scripts to the
running vagrant node.

```
> bin/init-node.sh
```

Ensure the docker images are pre-loaded on each node.

```
> bin/pull-images.sh
```

## Confluent Zookeeper

```
> # to start zookeeper
> bin/start.sh zk
> # to stop zookeeper
> bin/stop.sh zk
```

## Confluent Kafka

```
> # to start kafka
> bin/start.sh kafka
> # to stop kafka
> bin/stop.sh kafka
```
