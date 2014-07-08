ElasticSearch Dockerfile for Joukou
===================================
[![Build Status](https://circleci.com/gh/joukou/joukou-docker-elasticsearch/tree/develop.png?circle-token=6e6b2d72db673fbdf65b1b6999334a96d8b108c7)](https://circleci.com/gh/joukou/joukou-docker-elasticsearch/tree/develop) [![Docker Repository on Quay.io](https://quay.io/repository/joukou/elasticsearch/status?token=93f0d6bc-48fa-46af-983a-865b9fc5a99a "Docker Repository on Quay.io")](https://quay.io/repository/joukou/elasticsearch) [![Apache 2.0](http://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](#license) [![Stories in Ready](https://badge.waffle.io/joukou/joukou-docker-elasticsearch.png?label=ready&title=Ready)](http://waffle.io/joukou/joukou-docker-elasticsearch) [![IRC](http://img.shields.io/badge/IRC-%23joukou-blue.svg)](http://webchat.freenode.net/?channels=joukou)

[ElasticSearch](http://www.elasticsearch.org/) Dockerfile for
[Joukou](https://joukou.com).

Includes the
[RabbitMQ River](https://github.com/elasticsearch/elasticsearch-river-rabbitmq),
[JavaScript Language](https://github.com/elasticsearch/elasticsearch-lang-javascript),
[ElasticHQ](http://www.elastichq.org/), [Bigdesk](http://bigdesk.org/) and
[Marvel](http://www.elasticsearch.org/overview/marvel/) plugins.

## Usage

Executed via [Joukou Fleet Units](https://github.com/joukou/joukou-fleet).

## Environment Variables

| Name | Default |
| ------ | --------------- |
| ES_CLUSTER_NAME | `elasticsearch.production.akl1.joukou.local` |
| ES_NODE_NAME | `$(hostname -f)` |
| ES_NODE_MASTER | `true` |
| ES_NODE_DATA | `true` |
| ES_INDEX_NUMBER_OF_SHARDS | `5` |
| ES_INDEX_NUMBER_OF_REPLICAS | `1` |
| ES_PATH_CONF | `/etc/elasticsearch` |
| ES_PATH_DATA | `/var/lib/elasticsearch` |
| ES_PATH_WORK | `/tmp/elasticsearch` |
| ES_PATH_LOGS | `/var/log/elasticsearch` |
| ES_PATH_PLUGINS | `/usr/share/elasticsearch/plugins` |
| ES_PLUGIN_MANDATORY | `river-rabbitmq,lang-javascript` |
| ES_BOOSTRAP_MLOCKALL | `false` |
| ES_TRANSPORT_TCP_PORT | 9300 |
| ES_TRANSPORT_TCP_COMPRESS | `false` |
| ES_HTTP_PORT | `9200` |
| ES_HTTP_MAX_CONTENT_LENGTH | `100mb` |

## Base Image

See [`quay.io/joukou/java`](https://github.com/joukou/joukou-docker-java).

## License

Copyright &copy; 2014 Joukou Ltd.

ElasticSearch Dockerfile for Joukou is under the Apache 2.0 license. See the
[LICENSE](LICENSE) file for details.
