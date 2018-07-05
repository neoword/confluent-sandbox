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

## Start Confluent Zookeeper

```
> bin/start-zk.sh
```

## Stop Confluent Zookeeper

```
> bin/stop-zk.sh
```
