FROM maven:3.5-jdk-8

RUN apt-get update -qq
RUN apt-get install -y wget
WORKDIR /src

RUN wget -O flink-release-1.4.0-rc2.tar.gz https://github.com/apache/flink/archive/release-1.4.0-rc2.tar.gz && \
    tar zxvf flink-release-1.4.0-rc2.tar.gz && \
    cd flink-release-1.4.0-rc2 && \
    mvn clean install -DskipTests && \
    cd flink-dist && \
    mvn clean install
RUN mv /src/flink-release-1.4.0-rc2/flink-dist/target/flink-1.4.0-bin/flink-1.4.0 /opt/flink

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["help"]
