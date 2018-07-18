# Nomad job for kafka
# DISCLAIMER: This is intended for learning purposes only. It has not been tested for PRODUCTION environments.
job "kafka" {
    region = "global"
    datacenters = ["dc1"]
    type = "service"

    # Run tasks in serial or parallel (1 for serial)
    update {
        max_parallel = 1
    }

    # define job constraints
    constraint {
        attribute = "${attr.kernel.name}"
        value = "linux"
    }

    # ensure we are only on the nodes that have kafka enabled... ensure these are only 3 nodes
    # TODO - Need to add meta.kafka to be kafka specific (#8)
    # TODO - Right now piggy-back on ZK meta. Need to add a separate, distinct kafka meta.
    constraint {
        attribute = "${meta.kafka}"
        value = "true"
    }

    # define group
    group "kafka-group" {

        # define the number of times the tasks need to be executed
        count = 3

        # ensure we are on 3 different nodes
        constraint {
            operator  = "distinct_hosts"
            value     = "true"
        }

        # specify the number of attemtps to run the job within the specified interval
        restart {
            attempts = 10
            interval = "5m"
            delay = "25s"
            mode = "fail"
        }

        task "kafka" {
            driver = "docker"
            template {
              data        = <<EOT
                # generated at deployment
                CONFLUENT_VERSION = 4.1.1-2
                {{$i := env "NOMAD_ALLOC_INDEX"}}
                KAFKA_BROKER_ID={{$i | parseInt | add 1}}
                KAFKA_ZOOKEEPER_CONNECT=node2:2181,node3:2181,node4:2181
                KAFKA_ADVERTISED_HOSTNAME={{if eq $i "0"}}node2{{else}}{{if eq $i "1"}}node3{{else}}node4{{end}}{{end}}
                KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://node{{$i | parseInt | add 2}}:9092
                KAFKA_DEFAULT_REPLICATION_FACTOR=3
              EOT
              destination = "kafka-env/kafka.env"
              env         = true
            }
            config {
                image = "confluentinc/cp-kafka:${CONFLUENT_VERSION}"
                hostname = "${KAFKA_ADVERTISED_HOSTNAME}"
                labels {
                    group = "confluent-kafka"
                }
                extra_hosts = [
                    "node1:192.168.33.10",
                    "node2:192.168.33.11",
                    "node3:192.168.33.12",
                    "node4:192.168.33.13"
                ]
                port_map {
                    kafka = 9092
                }
                volumes = [
                    "/opt/kafka/data:/var/lib/kafka/data",
                    "/opt/kafka/secrets:/etc/kafka/secrets"
                ]
            }
            resources {
                cpu = 1000
                memory = 512
                network {
                    mbits = 5
                    port "kafka" {
                      static = 9092
                    }
                }
            }
            service {
                name = "kafka"
                tags = ["kafka"]
                port = "kafka"
                address_mode = "driver"
# TODO - Need to add a health check
#                check {
#                    type = "tcp"
#                    port = "kafka"
#                    interval = "10s"
#                    timeout = "2s"
#                    check_restart {
#                        limit = 3
#                        grace = "90s"
#                        ignore_warnings = false
#                    }
#                }
            }
        }
    }
}
