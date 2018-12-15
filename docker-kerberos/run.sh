#!/bin/bash

generate_ssl_certs() {
    PASS="test1234"
    VALIDITY=365
    keytool -keystore /var/tls/$OUT.keystore.jks -alias $OUT.leap.local -validity $VALIDITY -genkey 
    openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY
    keytool -keystore /var/tls/$OUT.truststore.jks -alias CARoot -import -file ca-cert
    keytool -keystore /var/tls/$OUT.keystore.jks -alias $OUT.leap.local -certreq -file cert-file
    openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days $VALIDITY -CAcreateserial -passin pass:$PASS
    keytool -keystore /var/tls/$OUT.keystore.jks -alias CARoot -import -file ca-cert
    keytool -keystore /var/tls/$OUT.keystore.jks -alias $OUT.leap.local -import -file cert-signed   
}

BROKER_COUNT=1
ZOOKEEPER_COUNT=1
PASSWORD="changeme"
OTHERS=""
OUT=""
if ( ! getopts ":b:z:p:ho:" opt); then
	echo "Usage: `basename $0` options (-a) (-c value) (-d) (-e) -h for help";
	exit $E_OPTERROR;
fi

while getopts ":b:z:p:ho:" opt; do
  case $opt in
    b)
      BROKER_COUNT=$OPTARG
      ;;
    z)
      ZOOKEEPER_COUNT=$OPTARG
      ;;
    p)
      PASSWORD=$OPTARG
      ;;
    o)
      OTHERS=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

/usr/sbin/kdb5_util -P changeme create -s


openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY

for i in $(seq -f "%02g" 1 $BROKER_COUNT)
do
    /usr/sbin/kadmin.local -q "addprinc -randkey kafka/kfk$i.leap.local"
    /usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/kafka$i.keytab kafka/kfk$i.leap.local"
done

for i in $(seq -f "%02g" 1 $ZOOKEEPER_COUNT)
do
    /usr/sbin/kadmin.local -q "addprinc -randkey zookeeper/kzk$i.leap.local"
    /usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/zookeeper$i.keytab zookeeper/kzk$i.leap.local"
done


