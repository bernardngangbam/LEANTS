# First we create kafka topic

kafka-topics --bootstrap-server localhost:9092 --list

kafka-topics --bootstrap-server localhost:9092 --create --topic influx_temperature --partitions 3

# Now data consumption is happenning in the 3 different partitions
# from the consumer groups

kafka-consumer-groups --bootstrap-server localhost:9092 --list

kafka-console-consumer --bootstrap-server localhost:9092 --topic influx_temperature --group tempconsumer-group --from-beginning

kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group tempconsumer-group

GROUP              TOPIC              PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID                                           HOST            CLIENT-ID
tempconsumer-group influx_temperature 0          33993           33993           0               console-consumer-907bac25-7518-48c8-9acc-0acdf771e204 /127.0.0.1      console-consumer
tempconsumer-group influx_temperature 1          39351           39351           0               console-consumer-907bac25-7518-48c8-9acc-0acdf771e204 /127.0.0.1      console-consumer
tempconsumer-group influx_temperature 2          37249           37249           0               console-consumer-907bac25-7518-48c8-9acc-0acdf771e204 /127.0.0.1      console-consumer