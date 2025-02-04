FROM openjdk:11

# Set environment variables
ENV SEATUNNEL_HOME="/opt/seatunnel" \
    SEATUNNEL_VERSION="2.3.9"

# ENV TZ=Asia/Kolkata
#
# # Install tzdata and configure time zone
# RUN apt-get update && apt-get install -y tzdata && \
#     ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Download and extract SeaTunnel
RUN wget "https://archive.apache.org/dist/seatunnel/${SEATUNNEL_VERSION}/apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz" \
    && tar -xzvf "apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz" \
    && mv "apache-seatunnel-${SEATUNNEL_VERSION}" "$SEATUNNEL_HOME" \
    && rm "apache-seatunnel-${SEATUNNEL_VERSION}-bin.tar.gz"

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
