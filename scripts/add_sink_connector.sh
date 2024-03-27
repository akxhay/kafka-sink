#!/bin/bash
curl --location 'http://connect:8083/connectors' \
--header 'Content-Type: application/json' \
--data '{
    "name": "mongo-sink-student_stream_test-connector",
    "config": {
        "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
        "topics": "source.public.student_stream_test",
        "connection.uri": "mongodb://host.docker.internal:27017",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter",
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter.schemas.enable": false,
        "database": "SinkDb",
        "collection": "student_stream_test",
        "document.id.strategy": "com.mongodb.kafka.connect.sink.processor.id.strategy.PartialValueStrategy",
        "document.id.strategy.partial.value.projection.list": "id",
        "document.id.strategy.partial.value.projection.type": "ALLOWLIST",
        "writemodel.strategy": "com.mongodb.kafka.connect.sink.writemodel.strategy.ReplaceOneBusinessKeyStrategy"
    }
}'