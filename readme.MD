# Kafka sink

## Functionality
This Project will be used for setting up a Kafka sink connector to achieve data streaming between Postgres and MongoDB.

## Prerequisites

**Docker:**  (Recommended Docker Engine Version: 25.0.3)

**Postgres:**  (Recommended psql Version: 16.2)

**MongoDb:**  (Recommended mongod Version: 6.0.6)

**wal_level = logical**

wal_level logical is required for Debezium because it  ensures that PostgreSQL logs the necessary information in the WAL to facilitate accurate, granular, and consistent change data capture for  streaming purposes. 

you can check by this command
```postgres-psql
select * from pg_settings where name='wal_level';
```
It should return 'logical' if it is not, you can change it in postgresql.conf file and reconnect to PostgreSQL

## Configuration
### Source config
![add_source_connector.sh](scripts/add_source_connector.sh)
```json
{
  "database.hostname": "IP address of Postgres database",
  "database.port": "Port of Postgres database",
  "database.user": "Username for Postgres database",
  "database.password": "Password for Postgres database",
  "database.dbname": "DB name",
  "table.include.list": "Source Table name"
}
```
![add_sink_connector.sh](scripts/add_sink_connector.sh)
```json
{
        "topics": "Topic to listen, it can be checked with List Topics command after adding source connector",
        "connection.uri": "Connection uri for mongodb",
        "database": "Mongo db name",
        "collection": "collection to write"
    }
```

## Docker commands

#### Run docker
```shell
docker-compose up -d
```

#### Stop docker
```shell
docker-compose down
```

#### Stop docker with removing all images
```shell
docker-compose down -v --rmi all
```
### Connector commands

#### Check current connectors
```shell
docker exec -it kafka /bin/bash -c "curl -X GET http://connect:8083/connectors"
```

#### Delete if needed
```shell
docker exec -it kafka /bin/bash -c "curl -X DELETE http://connect:8083/connectors/mongo-sink-student_stream_test-connector"
docker exec -it kafka /bin/bash -c "curl -X DELETE http://connect:8083/connectors/postgres-source-student_stream_test-connector"
```
### Add Connector

#### Add mongo sink connector
```shell
docker cp scripts/add_sink_connector.sh kafka:/usr/bin/
docker exec kafka /bin/bash -c "sh /usr/bin/add_sink_connector.sh"
```

#### Add postgres source connector
```shell
docker cp scripts/add_source_connector.sh kafka:/usr/bin/
docker exec kafka /bin/bash -c "sh /usr/bin/add_source_connector.sh"
```


### Kafka commands
#### List Topics
```shell
docker exec -it kafka /bin/bash -c "/usr/bin/kafka-topics --list  --bootstrap-server kafka:29092"
```

#### consumer
```shell
docker exec -it kafka /bin/bash -c "/usr/bin/kafka-console-consumer --topic source.public.student_stream_test --from-beginning --bootstrap-server kafka:29092"
```

#### Producer
```shell
docker exec -it kafka /bin/bash -c "/usr/bin/kafka-console-producer --topic source.public.student_stream_test --bootstrap-server kafka:29092"
```


### Sql and mongo command to verify
```postgres-sql
INSERT INTO public.student_stream_test (first_name, last_name) VALUES ('Akshay', 'Sharma');
```
```shell
use SinkDb
db.student_stream_test.find({})

```
Result
```json
[{
  "_id": {
    "$oid": "66043a8a9e0ee0abbc175f4c"
  },
  "last_name": "Sharma",
  "id": 1,
  "first_name": "akshay"
}]
```