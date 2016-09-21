#!/usr/bin/bash

/usr/sbin/sshd -D &

/opt/spark/sbin/start-master.sh

/opt/spark/sbin/start-slaves.sh


sleep infinity