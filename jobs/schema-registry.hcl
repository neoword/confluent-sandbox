# Nomad job for schema-registry
# DISCLAIMER: This is intended for learning purposes only. It has not been tested for PRODUCTION environments.

job "schema-registry" {
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
        attribute = "${meta.schema-registry}"
        value = "true"
    }

    # define group
    group "sr-group" {

        # define the number of times the tasks need to be executed
        count = 1

        # ensure we are on different nodes
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

        task "schema-registry" {
            driver = "docker"
            template {
              data        = <<EOT
                # generated at deployment
                CONFLUENT_VERSION=4.1.1-2
                SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL=192.168.33.11:2181,192.168.33.12:2181,192.168.33.13:2181
                SCHEMA_REGISTRY_LISTENERS=http://0.0.0.0:8081
                SCHEMA_REGISTRY_DEBUG=true
                SCHEMA_REGISTRY_HOST_NAME=node2
                SCHEMA_REGISTRY_AVRO_COMPATIBILITY_LEVEL=backward_transitive
              EOT
              destination = "schema-registry-env/schema-registry.env"
              env         = true
            }
            config {
                image = "confluentinc/cp-schema-registry:${CONFLUENT_VERSION}"
                labels {
                    group = "confluent-schema-registry"
                }
                extra_hosts = [
                    "node1:192.168.33.10",
                    "node2:192.168.33.11",
                    "node3:192.168.33.12",
                    "node4:192.168.33.13"
                ]
                port_map {
                    sr = 8081
                }
                volumes = [
                    "/opt/schema-registry/secrets:/etc/schema-registry/secrets"
                ]
            }
            resources {
                cpu = 200
                memory = 256
                network {
                    mbits = 1
                    port "sr" {
                      static = 8081
                    }
                }
            }
            service {
                name = "schema-registry"
                tags = ["schema-registry"]
                port = "sr"
                address_mode = "driver"
                check {
                    type = "http"
                    port = "sr"
                    path = "/"
                    interval = "10s"
                    timeout = "2s"
                    check_restart {
                        limit = 3
                        grace = "90s"
                        ignore_warnings = false
                    }
                }
            }
        }
    }
}
