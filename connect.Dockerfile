FROM confluentinc/cp-kafka-connect:7.2.5

# Install MongoDB connector
RUN confluent-hub install --no-prompt --verbose mongodb/kafka-connect-mongodb:latest

# Install Debezium connector for PostgreSQL
RUN confluent-hub install --no-prompt --verbose debezium/debezium-connector-postgresql:latest

# Set plugin path (already set, but included for clarity)
ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"
