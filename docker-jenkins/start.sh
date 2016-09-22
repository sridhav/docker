#!/usr/bin/env bash

/etc/init.d/jenkins start
echo -e "\n\n########## RSA pub key #################\n"
cat /home/jenkins/.ssh/id_rsa.pub
echo -e "\n########################################\n\n"

while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ] ;
do
    sleep 2
done


echo -e "\n\n########## ADMIN PASSWORD ################\n"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo -e "\n##########################################\n\n"

sleep infinity