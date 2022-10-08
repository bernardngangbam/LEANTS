sudo apt-get update
sudo apt-get upgrade

curl -sL https://repos.influxdata.com/influxdb.key | suod apt-key add -

source /etc/lsb-release

echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" |sudo tee /etc/apt/sources.list.d/influxdb.list

sudo apt-get install influxdb

# Start influxdb server locally
sudo server influxdb start

# Check and verify influxdb started
sudo netstat -plnt | grep LISTEN

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      759/cupsd           
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      744/systemd-resolve 
tcp        0      0 127.0.0.1:2375          0.0.0.0:*               LISTEN      1100/dockerd        
tcp        0      0 127.0.0.1:8088          0.0.0.0:*               LISTEN      1013/influxd        
tcp6       0      0 :::8086                 :::*                    LISTEN      1013/influxd        
tcp6       0      0 ::1:631                 :::*                    LISTEN      759/cupsd    

# Launch influx
influx

Connected to http://localhost:8086 version 1.8.10
InfluxDB shell version: 1.8.10
> show databases
name: databases
name
----
_internal
> create database temperature
> show databases
name: databases
name
----
_internal
temperature
> use temperature
Using database temperature
> show measurements
name: measurements
name
----
temperature_data
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    7459
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    17314
> exit

# Note: count increases as data is still streaming into influxdb

# Launching after sometime to verify data stream

influx

Connected to http://localhost:8086 version 1.8.10
InfluxDB shell version: 1.8.10
> use temperature
Using database temperature
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    57212
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    57755
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    58183
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    58772
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    64969
> exit

# Data is still streaming into influxdb
# On stopping read-data-into-influxdb.py the count becomes constant

influx

Connected to http://localhost:8086 version 1.8.10
InfluxDB shell version: 1.8.10
> use temperature
Using database temperature
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    109975
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    110341
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    113113
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    113113
> select count(temperature) from temperature_data
name: temperature_data
time count
---- -----
0    113113
> exit
