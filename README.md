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

### Start docker-registry
```
> # to start docker-registry
> bin/start.sh docker-registry

> # to stop docker-registry
> bin/stop.sh docker-registry
```

### Pre-cache images
Ensure the docker images are pre-loaded on each node.

```
> bin/pull-images.sh
```

## Confluent Zookeeper

```
> # to clean out zookeeper data dirs
> bin/clean-zk-dirs.sh

> # to start zookeeper
> bin/start.sh zk

> # to stop zookeeper
> bin/stop.sh zk
```

## Confluent Kafka

```
> # to clean out kafka data dirs
> bin/clean-kafka-dirs.sh

> # to start kafka
> bin/start.sh kafka

> # to stop kafka
> bin/stop.sh kafka
```

## Confluent Schema-Registry

```
> # to start schema-registry
> bin/start.sh schema-registry

> # to stop schema-registry
> bin/stop.sh schema-registry
```
