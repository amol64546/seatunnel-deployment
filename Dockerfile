FROM openjdk:11

# Set environment variables
ENV SEATUNNEL_HOME="/opt/seatunnel" \
    SEATUNNEL_VERSION="2.3.9"

# Download and extract SeaTunnel
RUN wget "https://archive.apache.org/dist/seatunnel/${SEATUNNEL_VERSION}/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz" \
    && tar -xzvf "apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz" \
    && mv "apache-seatunnel-${SEATUNNEL_VERSION}" "$SEATUNNEL_HOME" \
    && rm "apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz"

# Modify config/plugin_config to include all required connectors
RUN echo "--connectors-v2--\n \
    connector-cassandra\n \
    connector-cdc-mysql\n \
    connector-cdc-mongodb\n \
    connector-cdc-postgres\n \
    connector-cdc-oracle\n \
    connector-cdc-tidb\n \
    connector-clickhouse\n \
    connector-elasticsearch\n \
    connector-file-ftp\n \
    connector-file-local\n \
    connector-hudi\n \
    connector-influxdb\n \
    connector-jdbc\n \
    connector-kafka\n \
    connector-mongodb\n \
    connector-neo4j\n \
    connector-redis" > "$SEATUNNEL_HOME/config/plugin_config"
    
# Install plugins
WORKDIR "$SEATUNNEL_HOME"
RUN sh bin/install-plugin.sh "$SEATUNNEL_VERSION"

# Download necessary driver JAR files and copy to the lib directory
RUN wget -P "$SEATUNNEL_HOME/lib/" "https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar" \
    && wget -P "$SEATUNNEL_HOME/lib/" "https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.3/postgresql-42.7.3.jar" \
    && wget -P "$SEATUNNEL_HOME/lib/" "https://repo1.maven.org/maven2/org/tikv/tikv-client-java/3.3.5/tikv-client-java-3.3.5.jar" \
    && wget -P "$SEATUNNEL_HOME/lib/" "https://repo1.maven.org/maven2/net/postgis/postgis-jdbc/2024.1.0/postgis-jdbc-2024.1.0.jar" \
    && wget -P "$SEATUNNEL_HOME/lib/" "https://repo1.maven.org/maven2/org/neo4j/driver/neo4j-java-driver/5.27.0/neo4j-java-driver-5.27.0.jar"

# Set the working directory
WORKDIR "$SEATUNNEL_HOME"
