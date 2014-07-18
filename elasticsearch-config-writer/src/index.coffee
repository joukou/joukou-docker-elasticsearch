###*
@author Isaac Johnston <isaac.johnston@joukou.com>
@copyright 2014 Joukou Ltd. All rights reserved.
###

fs   = require( 'fs' )
path = require( 'path' )
yaml = require( 'js-yaml' )

toBoolean = ( value, defaultValue = false ) ->
  if value is 'true'
    true
  else if value is 'false'
    false
  else
    defaultValue

config = {}

config.cluster =
  name: process.env.ES_CLUSTER_NAME or "#{process.env.ES_ENV}.joukou.com"

if process.env.ES_NODE_NAME
  config.node =
    name: process.env.ES_NODE_NAME
    master: toBoolean( process.env.ES_NODE_MASTER, true )
    data: toBoolean( process.env.ES_NODE_DATA, true )

config.index =
  number_of_shards: process.env.ES_INDEX_NUMBER_OF_SHARDS or 5
  number_of_replicas: process.env.ES_INDEX_NUMBER_OF_REPLICAS or 1

config.path =
  conf: process.env.ES_PATH_CONF or '/etc/elasticsearch'
  data: process.env.ES_PATH_DATA or '/var/lib/elasticsearch'
  work: process.env.ES_PATH_WORK or '/tmp'
  logs: process.env.ES_PATH_LOGS or '/var/log/elasticsearch'

config.plugin =
  mandatory: process.env.ES_PLUGIN_MANDATORY or 'mapper-attachments,lang-groovy,river-rabbitmq,lang-javascript'

config.bootstrap =
  mlockall: toBoolean( process.env.ES_BOOTSTRAP_MLOCKALL, false )

config.transport =
  tcp:
    port: process.env.ES_TRANSPORT_TCP_PORT or 9300
    compress: toBoolean( process.env.ES_TRANSPORT_TCP_COMPRESS, false )

config.http =
  port: process.env.ES_HTTP_PORT or 9200
  max_content_length: process.env.ES_HTTP_MAX_CONTENT_LENGTH or '100mb'

console.log(require('util').inspect(config, depth: 10))

fs.writeFileSync( path.join( process.env.ES_PATH_CONF or '/etc/elasticsearch', 'elasticsearch.yml' ), yaml.safeDump( config ) )