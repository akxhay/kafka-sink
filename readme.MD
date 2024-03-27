# SND dev tools

## Functionality

## Prerequisite
## Check current connectors
```shell
docker exec -it kafka /bin/bash -c "curl -X GET http://connect:8083/connectors"
```

## Delete if needed
```shell
docker exec -it kafka /bin/bash -c "curl -X DELETE http://connect:8083/connectors/mongo-sink-student_stream_test-connector"
docker exec -it kafka /bin/bash -c "curl -X DELETE http://connect:8083/connectors/postgres-source-student_stream_test-connector"
```
## Add Connector
### Add mongo sink connector
```shell
docker cp scripts/add_sink_connector.sh kafka:/usr/bin/
docker exec kafka /bin/bash -c "sh /usr/bin/add_sink_connector.sh"
```

### Add postgres source connector
```shell
docker cp scripts/add_source_connector.sh kafka:/usr/bin/
docker exec kafka /bin/bash -c "sh /usr/bin/add_source_connector.sh"
```


## Some kafka commands
### List Topics

```shell
docker exec -it kafka /bin/bash -c "/usr/bin/kafka-topics --list  --bootstrap-server kafka:29092"
```

### Some kafka commands
### consumer

```shell
docker exec -it kafka /bin/bash -c "/usr/bin/kafka-console-consumer --topic source.public.student_stream_test --from-beginning --bootstrap-server kafka:29092"
```

### Some kafka commands
### Producer

```shell
docker exec -it kafka /bin/bash -c "/usr/bin/kafka-console-producer --topic source.public.student_stream_test --bootstrap-server kafka:29092"
```