ElasticSearch Dockerfile [![Proprietary](http://img.shields.io/badge/license-proprietary-red.svg)](#license)
=========================

`joukou/java` base image + ElasticSearch. Includes the RabbitMQ River,
JavaScript Language and Marvel plugins.

## Environment Variables

| Name | Description | Default |
| ------ | ------------- | --------------- | 
| ES_ENV | Tier name of the stage in the release process; i.e., `production`, `staging` or `development`. | `development` |
| ES_CLUSTER_NAME | Identifies cluster for auto-discovery. If running multiple clusters on the same network, make sure you're using unique names. | `${ES_ENV}.joukou.com` |
| ES_NODE_NAME | Node names are generated dynamically on startup, or may be configured manually. | Dynamic |
| ES_NODE_MASTER | Allow this node to be eligible as a master node | `true` |
| ES_NODE_DATA | Allow this node to store data | `true` |
| ES_INDEX_NUMBER_OF_SHARDS | Set the number of shards (splits) of an index  | `5` |
| ES_INDEX_NUMBER_OF_REPLICAS | Set the number of replicas (additional copies) of an index | `1` |
| ES_PATH_CONF | Path to directory containing configuration | `/etc/elasticsearch` (created from these environment variables) |
| ES_PATH_DATA | Path to directory where to store index data allocated for this node | `/var/lib/elasticsearch` |
| ES_PATH_WORK | Path to temporary files | |
| ES_PATH_LOGS | Path to log files | `/var/log/elasticsearch` |
| ES_PATH_PLUGINS | Path to where plugins are installed |
| ES_PLUGIN_MANDATORY | If a plugin listed here is not installed for current node, the node will not start | `mapper-attachments,lang-groovy,river-rabbitmq,lang-javascript` |
| ES_BOOSTRAP_MLOCKALL | Elasticsearch performs poorly when JVM starts swapping: you should ensure that it _never_ swaps. Set this property to true to lock the memory | `false` |
| ES_TRANSPORT_TCP_PORT | Set a custom port for the node to node communication | 9300 |
| ES_TRANSPORT_TCP_COMPRESS | Enable compression for all communication between nodes | `false` |
| ES_HTTP_PORT | Set a custom port to listen for HTTP traffic | `9200` |
| ES_HTTP_MAX_CONTENT_LENGTH | Set a custom allowed content length | `100mb` |

If required additional configuration options may be added in
`elasticsearch-config-writer` and should be added to the above table.

## License

Copyright &copy; Joukou Ltd. All rights reserved.
