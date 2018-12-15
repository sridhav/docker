FROM debian:jessie

MAINTAINER Sridhar Vemula

RUN echo "deb http://deb.debian.org/debian jessie contrib non-free" >> /etc/apt/sources.list

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install krb5-admin-server krb5-kdc krb5-user default-jre

ADD ./krb5.conf /etc/

ADD ./run.sh /tmp/run.sh

RUN chmod +x /tmp/run.sh 

EXPOSE 88

EXPOSE 754

CMD ["/bin/bash", "-c", "/tmp/run.sh -d /var/security -v 365 kafka zookeeper client"]