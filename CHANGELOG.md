# CHANGELOG.md
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [v0.4] - Unreleased
### Added
* Add support for docker registry (#15)
* Added 256M memory to kafka container

### Changed
* Fixed schema-registry fails to start (#18)
* Adding bootstrap servers to schema-registry config (#19)

## [v0.3] - 20180822
### Added
* Add support for confluent schema-registry (#12, #9)
* Clean kafka dir scripts added (#11)
* Add meta.constraint that is Kafka specific (#10)

## [v0.2] - 20180714
### Added
* Add support for confluent kafka (#7)

## v0.1 - 20180706
### Added
* Initial version
* Supports confluent-zookeeper (#3, #4)
* Added CONTRIBUTING and CHANGELOG (#1, #5)

[v0.3]: https://github.com/neoword/confluent-sandbox/compare/v0.2...v0.3
[v0.2]: https://github.com/neoword/confluent-sandbox/compare/v0.1...v0.2
