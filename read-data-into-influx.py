import pandas as pd
from influxdb import InfluxDBClient

client = InfluxDBClient(host='localhost',port=8086)
client.switch_database('temperature')

file_path = r"/home/bernard/RimoR/Temperature_data.csv"
csvReader = pd.read_csv(file_path)

for row_index, row in csvReader.iterrows():
	beaconId = row[1]
	loc = row[2]
	temp = row[3]
	time = row[0]
	json_body = [
		{
			"measurement": "temperature_data",
			"tags":{
				"beacon_id":beaconId
				},
			"fields":{
				"time":time,
				"location":loc,
				"temperature":temp,
				}
		}
	]
	client.write_points(json_body)
