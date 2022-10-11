# After starting confluent services we load the influxdb connect
# source connector to load data from influxdb into kafka topic.

confluent local services connect connector load influx-source-connector --config etc/kafka-connect-influxdb/influxdb-source-connector.properties

The local commands are intended for a single-node development environment only,
NOT for production usage. https://docs.confluent.io/current/cli/index.html

{
  "name": "influx-source-connector",
  "config": {
    "batch.size": "7500",
    "connector.class": "io.confluent.influxdb.source.InfluxdbSourceConnector",
    "influxdb.db": "temperature",
    "influxdb.url": "http://localhost:8086",
    "mode": "timestamp",
    "tasks.max": "1",
    "topic.prefix": "influx_",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": "false",
    "name": "influx-source-connector"
  },
  "tasks": [],
  "type": "source"
}

# Check status of the source connector

confluent local services connect connector status

The local commands are intended for a single-node development environment only,
NOT for production usage. https://docs.confluent.io/current/cli/index.html

[
  "influx-source-connector"
]

# To unload the connector

confluent local services connect connector unload influx-source-connector

The local commands are intended for a single-node development environment only,
NOT for production usage. https://docs.confluent.io/current/cli/index.html

Success.

# Check status after unloading to verify

confluent local services connect connector status
The local commands are intended for a single-node development environment only,
NOT for production usage. https://docs.confluent.io/current/cli/index.html

[]
