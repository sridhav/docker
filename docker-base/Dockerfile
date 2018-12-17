FROM confluentinc/cp-base

MAINTAINER Sridhar Vemula

ADD jaas.tpl /opt/tpl/jaas.tpl

ADD krb5.tpl /opt/tpl/krb5.tpl

ADD props.tpl /opt/tpl/props.tpl

ADD tpl /opt/tpl/tpl

RUN echo "deb http://deb.debian.org/debian jessie contrib non-free" >> /etc/apt/sources.list

RUN apt-get -y update && \
    apt-get install -y dnsutils telnet