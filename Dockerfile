FROM ubuntu:latest

# Set version and github repo which you want to build from
ARG DRUID_VERSION=0.13.0-incubating
ARG ZOOKEEPER_VERSION=3.4.11

# Java 8
#RUN sed -i -e 's/http:\/\/archive/mirror:\/\/mirrors/' -e 's/http:\/\/security/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list && \
      #echo "Acquire {http {Timeout \"60\";}; ftp {Timeout \"60\";};};" > /etc/apt/apt.conf.d/custom-apt.conf && \
RUN apt-get update && apt-get dist-upgrade --yes && apt-get install -y software-properties-common && \
      apt-add-repository -y ppa:webupd8team/java && \
      apt-get purge --auto-remove -y software-properties-common && apt-get update && \
      echo oracle-java-8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
      apt-get install -y oracle-java8-installer oracle-java8-set-default git && \
      apt-get autoremove -y && apt-get clean && rm -rf /var/cache/oracle-jdk8-installer && \
      rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN wget http://mirrors.estointernet.in/apache/incubator/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz && \
      tar -xzf apache-druid-${DRUID_VERSION}-bin.tar.gz && \
      mv apache-druid-${DRUID_VERSION} druid

WORKDIR /druid

RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
      tar -xzf zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
      mv zookeeper-${ZOOKEEPER_VERSION} zk && \
      rm -rf conf

# Expose ports:
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 8090: HTTP (overlord)
# - 8091: HTTP (middlemanager)
# - 2181 2888 3888: ZooKeeper
EXPOSE 8081
EXPOSE 8082
EXPOSE 8083
EXPOSE 8090
EXPOSE 8091
EXPOSE 2181 2888 3888

ENTRYPOINT [ "/bin/bash" ]
