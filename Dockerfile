FROM joukou/java
MAINTAINER Isaac Johnston isaac.johnston@joukou.com

ENV DEBIAN_FRONTEND noninteractive

# Add the ElasticSearch public key to the trusted key list
ADD elasticsearch-signing-key-public.asc /tmp/elasticsearch-signing-key-public.asc
RUN apt-key add /tmp/elasticsearch-signing-key-public.asc

# Add the ElasticSearch apt repository to the apt data sources
ADD etc/apt/sources.list.d/elasticsearch.list /etc/apt/sources.list.d/elasticsearch.list

# Install ElasticSearch
RUN apt-get update -qq && apt-get install -y \
  elasticsearch

# Install ElasticSearch plugins
RUN /usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/elasticsearch-river-rabbitmq/2.0.0.RC1
RUN /usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/elasticsearch-lang-javascript/2.2.0
RUN /usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/marvel/latest

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose ports
#   9200  intra-cluster   ElasticSearch HTTP
#   9300  intra-cluster   ElasticSearch Node-to-Node
#   54328 intra-cluster   ElasticSearch Service Discovery
EXPOSE 9200 9300 54328