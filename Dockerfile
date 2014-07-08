# Copyright 2014 Joukou Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM quay.io/joukou/java
MAINTAINER Isaac Johnston <isaac.johnston@joukou.com>

ENV DEBIAN_FRONTEND noninteractive
ENV ES_CLUSTER_NAME elasticsearch.production.akl1.joukou.local
ENV ES_NODE_MASTER true
ENV ES_NODE_DATA true
ENV ES_INDEX_NUMBER_OF_SHARDS 5
ENV ES_INDEX_NUMBER_OF_REPLICAS 1
ENV ES_HOME /usr/share/elasticsearch
ENV ES_PATH_CONF /etc/elasticsearch
ENV ES_PATH_DATA /var/lib/elasticsearch
ENV ES_PATH_WORK /tmp/elasticsearch
ENV ES_PATH_LOGS /var/log/elasticsearch
ENV ES_PATH_PLUGINS /usr/share/elasticsearch/plugins/
ENV ES_PLUGIN_MANDATORY river-rabbitmq,lang-javascript
ENV ES_BOOTSTRAP_MLOCKALL false
ENV ES_TRANSPORT_TCP_PORT 9300
ENV ES_TRANSPORT_TCP_COMPRESS false
ENV ES_HTTP_PORT 9200
ENV ES_HTTP_MAX_CONTENT_LENGTH 100mb
ENV ES_IFACE eth0
ENV ES_MAX_LOCKED_MEMORY 1000000
ENV ES_MAX_OPEN_FILES 65535
ENV ES_MAX_MAP_COUNT 262144
ENV ES_DAEMON_OPTS -Des.default.config=$ES_PATH_CONF/elasticsearch.yml -Des.default.path.home=$ES_HOME -Des.default.path.logs=$ES_PATH_DATA -Des.default.path.work=$ES_PATH_WORK -Des.default.path.conf=$ES_PATH_CONF

# Add ElasticSearch public key
ADD elasticsearch-signing-key-public.asc /tmp/elasticsearch-signing-key-public.asc

# Add ElasticSearch apt repository to the apt data sources
ADD etc/apt/sources.list.d/elasticsearch.list /etc/apt/sources.list.d/elasticsearch.list

# Add ElasticSearch public key to the trusted key list
RUN apt-key add /tmp/elasticsearch-signing-key-public.asc && \

# Install ElasticSearch
apt-get update -qq && \
apt-get install --no-install-recommends -y elasticsearch && \

# Install ElasticSearch plugins
/usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/elasticsearch-river-rabbitmq/2.0.0.RC1 && \
/usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/elasticsearch-lang-javascript/2.2.0 && \
/usr/share/elasticsearch/bin/plugin -i \
  elasticsearch/marvel/latest && \
/usr/share/elasticsearch/bin/plugin -i \
  royrusso/elasticsearch-HQ && \
/usr/share/elasticsearch/bin/plugin -i \
  lukas-vlcek/bigdesk/2.4.0 && \

# Cleanup
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add ElasticSearch configuration
ADD etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/
ADD etc/elasticsearch/logging.yml /etc/elasticsearch/

VOLUME [ "/var/lib/elasticsearch", "/var/log/elasticsearch" ]

# Expose ports
#   9200  ElasticSearch HTTP
#   9300  ElasticSearch Node-to-Node
#   54328 ElasticSearch Service Discovery
EXPOSE 9200 9300 54328

ADD bin/boot /bin/
CMD [ "/bin/boot" ]