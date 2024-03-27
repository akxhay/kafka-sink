#!/bin/bash
curl --location 'http://connect:8083/connectors' \
--header 'Content-Type: application/json' \
--data '{
    "name": "postgres-source-student_stream_test-connector",
    "config": {
        "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
        "database.hostname": "host.docker.internal",
        "database.port": "5432",
        "database.user": "postgres",
        "database.password": "postgres",
        "database.dbname": "postgres",
        "plugin.name": "pgoutput",
        "database.server.name": "source",
        "key.converter.schemas.enable": "false",
        "value.converter.schemas.enable": "false",
        "transforms": "unwrap",
        "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter",
        "table.include.list": "public.student_stream_test",
        "slot.name": "dbz_student_slot",
        "topic.prefix":"source"
    }
}'