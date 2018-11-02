FROM centos:7

MAINTAINER Sridhar Vemula

RUN yum -y install epel-release && yum -y update

# Application
RUN yum -y install wget java-1.8.0-openjdk-devel

RUN wget http://mirrors.estointernet.in/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz -P /opt/

RUN tar xvzf /opt/apache-maven-3.5.4-bin.tar.gz -C /opt/ && mv /opt/apache-maven-3.5.4 /opt/maven

ENV JAVA_HOME /usr/lib/jvm/java/

ENV M2_HOME /opt/maven

ENV PATH $PATH:${M2_HOME}/bin