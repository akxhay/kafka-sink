# Kafka sink

## Functionality
This Project will be used for setting up a Kafka sink connector to achieve data streaming between Postgres and MongoDB.

## Prerequisites

**Docker:**  (Recommended Docker Engine Version: 25.0.3)

**Postgres:**  (Recommended psql Version: 16.2)

**MongoDb:**  (Recommended mongod Version: 6.0.6)

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