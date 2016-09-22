FROM debian:jessie

MAINTAINER Sridhar Vemula

# SSH installation and ssh key generation
RUN apt-get update
RUN apt-get -y install openssh-server openssh-client
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
RUN useradd -m -d /home/jenkins -s /bin/bash -G sudo jenkins
RUN /usr/bin/ssh-keygen -A
RUN su - jenkins -c "mkdir -p /home/jenkins/.ssh/"
RUN su - jenkins -c '/usr/bin/ssh-keygen -b 2048 -t rsa -f /home/jenkins/.ssh/id_rsa -q -N ""'
RUN cat /home/jenkins/.ssh/id_rsa.pub

# Install jenkins
RUN apt-get -y install wget
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key |  apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-get -y update
RUN apt-get -y install jenkins

ADD start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh

CMD /tmp/start.sh