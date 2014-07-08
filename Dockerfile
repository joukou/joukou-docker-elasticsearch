FROM joukou/java
MAINTAINER Isaac Johnston isaac.johnston@joukou.com

ENV DEBIAN_FRONTEND noninteractive

RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.2/debian stable main" >> /etc/apt/sources.list
RUN apt-get update -qq && apt-get install -y elasticsearch
RUN /usr/share/elasticsearch/bin/plugin -i elasticsearch/elasticsearch-river-rabbitmq/2.0.0.RC1
RUN /usr/share/elasticsearch/bin/plugin -i elasticsearch/elasticsearch-lang-javascript/2.2.0
RUN /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*