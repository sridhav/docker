FROM debian:jessie

MAINTAINER ACT

RUN echo "deb http://deb.debian.org/debian jessie contrib non-free" >> /etc/apt/sources.list

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install krb5-admin-server krb5-kdc krb5-user default-jre

COPY krb5.conf /etc/

COPY run.sh /tmp/run.sh

RUN mkdir -p /var/keytabs && mkdir -p /var/tls && chmod +x /tmp/run.sh 

CMD ["sh", "/tmp/run.sh"]