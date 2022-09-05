# Stage 1
FROM maven:3.3.9-jdk-8-alpine as builder
LABEL maintainer="ABC"

ARG LENSES_CASSANDRA_CONNECTOR=https://github.com/lensesio/stream-reactor/releases/download/3.0.1/kafka-connect-cassandra-3.0.1-2.5.0-all.tar.gz
ARG PLUGINS_FOLDER=/home/plugins

RUN apk add --no-cache git wget tar
RUN mkdir -p ${PLUGINS_FOLDER}

# Maven Configuration Files
COPY ./settings.xml /home/
COPY ./pom.xml /home/

# Get Confluent and other maven-based connectors
RUN cd /home \
  && mvn --settings settings.xml dependency:copy-dependencies \
  && cp -r /home/target/dependency/ ${PLUGINS_FOLDER}

# Get cassandra source connectors from github maintained by lenses.io
RUN wget ${LENSES_CASSANDRA_CONNECTOR} \
  && tar -xvf kafka-connect-cassandra-3.0.1-2.5.0-all.tar.gz \
  && cp kafka-connect-cassandra-3.0.1-2.5.0-all.jar ${PLUGINS_FOLDER}

# Stage 2
#FROM strimzi/kafka:0.19.0-kafka-2.5.0
FROM quay.io/strimzi/kafka:0.28.0-kafka-3.1.0
USER root:root
ARG PLUGINS_FOLDER=/home/plugins
COPY --from=builder ${PLUGINS_FOLDER} /opt/kafka/plugins/
USER 1001