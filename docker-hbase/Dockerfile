FROM centos:7.2.1511

MAINTAINER Sridhar Vemula

RUN yum -y install epel-release wget nano 

RUN yum clean all && yum -y update

RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm" 

RUN rpm -Uvh jdk-8u60-linux-x64.rpm && javac -version && java -version

RUN mkdir /opt/hbase

RUN wget https://archive.apache.org/dist/hbase/hbase-1.0.0/hbase-1.0.0-bin.tar.gz -O /opt/hbase/hbase-1.0.0-bin.tar.gz

RUN cd /opt/hbase && tar xvzf hbase-1.0.0-bin.tar.gz

ADD hbase-site.xml /opt/hbase/hbase-1.0.0/conf/hbase-site.xml

ENV JAVA_HOME=/usr/java/jdk1.8.0_60/

# zookeeper
EXPOSE 2181
# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

RUN rm -rf jdk-8u60-linux-x64.rpm

RUN rm -rf /opt/hbase/hbase-1.0.0-bin.tar.gz

ADD start.sh /tmp/start.sh

RUN chmod +x /tmp/start.sh

CMD /tmp/start.sh