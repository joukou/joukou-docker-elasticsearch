FROM joukou/java
MAINTAINER Isaac Johnston isaac.johnston@joukou.com

ENV DEBIAN_FRONTEND noninteractive
ENV ES_ENV development
ENV ES_CLUSTER_NAME development.joukou.com
ENV ES_NODE_MASTER true
ENV ES_NODE_DATA true
ENV ES_INDEX_NUMBER_OF_SHARDS 5
ENV ES_INDEX_NUMBER_OF_REPLICAS 1
ENV ES_PATH_CONF /etc/elasticsearch
ENV ES_PATH_DATA /var/lib/elasticsearch
ENV ES_PATH_WORK /tmp
ENV ES_PATH_LOGS /var/log/elasticsearch
ENV ES_PLUGIN_MANDATORY mapper-attachments,lang-groovy,river-rabbitmq,lang-javascript
ENV ES_BOOTSTRAP_MLOCKALL false
ENV ES_TRANSPORT_TCP_PORT 9300
ENV ES_TRANSPORT_TCP_COMPRESS false
ENV ES_HTTP_PORT 9200
ENV ES_HTTP_MAX_CONTENT_LENGTH 100mb

# Add the ElasticSearch public key to the trusted key list
ADD elasticsearch-signing-key-public.asc /tmp/elasticsearch-signing-key-public.asc
RUN apt-key add /tmp/elasticsearch-signing-key-public.asc

# Add the ElasticSearch apt repository to the apt data sources
ADD etc/apt/sources.list.d/elasticsearch.list /etc/apt/sources.list.d/elasticsearch.list

# Add the supervisord configuration
ADD etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install ElasticSearch and Supervisor
RUN apt-get update -qq && apt-get install -y \
  elasticsearch \
  supervisor

# Install ElasticSearch plugins
RUN /usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/elasticsearch-river-rabbitmq/2.0.0.RC1
RUN /usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/elasticsearch-lang-javascript/2.2.0
RUN /usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/marvel/latest

# Install ElasticSearch config writer
ADD elasticsearch-config-writer /opt/
WORKDIR /opt/elasticsearch-config-writer
RUN npm install
RUN ./node_modules/.bin/gulp

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME [ "/var/log/elasticsearch", "/var/log/supervisord" ]

# Expose ports
#   9200  intra-cluster   ElasticSearch HTTP
#   9300  intra-cluster   ElasticSearch Node-to-Node
#   54328 intra-cluster   ElasticSearch Service Discovery
EXPOSE 9200 9300 54328

ENTRYPOINT [ "/usr/bin/supervisord" ]
CMD [ "-c", "/etc/supervisor/conf.d/supervisord.conf" ]