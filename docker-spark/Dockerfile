FROM centos:7.2.1511

# Required libs
RUN yum -y install wget nano

# Spark installation
RUN cd /tmp && wget http://apache.mirrors.ionfish.org/spark/spark-2.0.0/spark-2.0.0-bin-hadoop2.7.tgz
RUN tar xvzf /tmp/spark-2.0.0-bin-hadoop2.7.tgz -C /opt/
RUN mv /opt/spark-2.0.0-bin-hadoop2.7 /opt/spark

# Java installation
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm" 
RUN yum -y --nogpgcheck localinstall jdk-8u60-linux-x64.rpm && javac -version && java -version
ENV JAVA_HOME=/usr/java/jdk1.8.0_60/
RUN rm -rf jdk-8u60-linux-x64.rpm

# SSH installation and ssh key generation
RUN yum -y install openssh-server openssh-clients
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
RUN /usr/bin/ssh-keygen -A
RUN /usr/bin/ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# Exposed Ports
EXPOSE 8080
EXPOSE 7077

# Shell script to run
ADD ./run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
CMD /tmp/run.sh