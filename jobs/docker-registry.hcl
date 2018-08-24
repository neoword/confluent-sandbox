# Nomad job for docker-registry
# DISCLAIMER: This is intended for learning purposes only. It has not been tested for PRODUCTION environments.
job "docker-registry" {
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

    # ensure we are only on the nodes that have docker-registry enabled...
    constraint {
        attribute = "${meta.docker-registry}"
        value = "true"
    }

    # define group
    group "docker-registry-group" {

        # define the number of times the tasks need to be executed
        count = 1

        # specify the number of attemtps to run the job within the specified interval
        restart {
            attempts = 10
            interval = "5m"
            delay = "25s"
            mode = "fail"
        }

        task "docker-registry" {
            driver = "docker"
            template {
              data        = <<EOT
                # generated at deployment
              EOT
              destination = "docker-registry-env/docker-registr.env"
              env         = true
            }
            config {
                image = "registry:2"
                labels {
                    group = "docker-registry"
                }
                extra_hosts = [
                    "node1:192.168.33.10",
                    "node2:192.168.33.11",
                    "node3:192.168.33.12",
                    "node4:192.168.33.13"
                ]
                port_map {
                    dr = 5000
                }
                volumes = []
            }
            resources {
                cpu = 250
                memory = 128
                network {
                    mbits = 5
                    port "dr" {
                      static = 5000
                    }
                }
            }
            service {
                name = "docker-registry"
                tags = ["docker-registry"]
                port = "dr"
                address_mode = "driver"
# TODO - Need to add a health check
#                check {
#                    type = "tcp"
#                    port = "dr"
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
