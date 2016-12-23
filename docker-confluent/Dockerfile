FROM centos:7

MAINTAINER Sridhar Vemula

RUN yum -y install wget net-tools

RUN yum -y update

RUN wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm" 

RUN rpm -Uvh jdk-8u60-linux-x64.rpm && javac -version && java -version && rm -rf jdk-8u60-linux-x64.rpm

RUN rpm --import http://packages.confluent.io/rpm/3.0/archive.key

ADD ./conf/confluent.repo /etc/yum.repos.d/confluent.repo

RUN yum -y clean all

RUN yum -y install confluent-platform-oss-2.11

RUN wget -q http://downloads.sourceforge.net/project/cyclops-group/jmxterm/1.0-alpha-4/jmxterm-1.0-alpha-4-uber.jar

ADD ./my_init.sh /sbin/my_init.sh

RUN chmod +x /sbin/my_init.sh

CMD /sbin/my_init.sh