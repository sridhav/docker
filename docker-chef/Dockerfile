FROM centos:7

MAINTAINER Sridhar Vemula

RUN yum -y install wget net-tools

RUN yum -y update

RUN wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm" 

RUN rpm -Uvh jdk-8u60-linux-x64.rpm && javac -version && java -version && rm -rf jdk-8u60-linux-x64.rpm

RUN rpm -Uvh  https://packages.chef.io/files/stable/chefdk/1.1.16/el/7/chefdk-1.1.16-1.el7.x86_64.rpm
