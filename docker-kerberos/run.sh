#!/bin/bash

# generate_ssl_certs() {
#     PASS="test1234"
#     VALIDITY=365
#     keytool -keystore /var/tls/$OUT.keystore.jks -alias $OUT.leap.local -validity $VALIDITY -genkey 
#     openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY
#     keytool -keystore /var/tls/$OUT.truststore.jks -alias CARoot -import -file ca-cert
#     keytool -keystore /var/tls/$OUT.keystore.jks -alias $OUT.leap.local -certreq -file cert-file
#     openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days $VALIDITY -CAcreateserial -passin pass:$PASS
#     keytool -keystore /var/tls/$OUT.keystore.jks -alias CARoot -import -file ca-cert
#     keytool -keystore /var/tls/$OUT.keystore.jks -alias $OUT.leap.local -import -file cert-signed   
# }

SASL_PASSWORD="changeme"
SSL_PASSWORD="changeme"
DIRECTORY="/var/security"
VALIDITY="365"
DOMAIN="leap.local"
NAMESPACE=""
ADD_SUB=""
if ( ! getopts ":p:s:d:u:v:n:a:h" opt); then
	echo "Usage: `basename $0` (-p value) (-s value) (-d value) (-u value) (-v value) (-n value) (-a value) -h arg1 arg2 ...";
	exit $E_OPTERROR;
fi

while getopts ":p:s:d:u:v:n:a:h" opt; do
  case $opt in
    p)
      SASL_PASSWORD=$OPTARG
      ;;
    s)
      SSL_PASSWORD=$OPTARG
      ;;
    d)
      DIRECTORY=$OPTARG
      ;;
    u)
      DOMAIN=$OPTARG
      DOMAIN=`echo $DOMAIN | tr A-Z a-z`
      ;;
    n)
      NAMESPACE="$OPTARG."
      NAMESPACE=`echo $NAMESPACE | tr A-Z a-z`
      ;;
    a)
      ADD_SUB="$OPTARG."
      ADD_SUB=`echo $ADD_SUB | tr A-Z a-z`
      ;;
    v)
      VALIDITY=$OPTARG
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

shift $(( OPTIND - 1 ))

# /usr/sbin/kdb5_util -P changeme create -s


# openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY

# for i in $(seq -f "%02g" 1 $BROKER_COUNT)
# do
#     /usr/sbin/kadmin.local -q "addprinc -randkey kafka/kfk$i.leap.local"
#     /usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/kafka$i.keytab kafka/kfk$i.leap.local"
# done

# for i in $(seq -f "%02g" 1 $ZOOKEEPER_COUNT)
# do
#     /usr/sbin/kadmin.local -q "addprinc -randkey zookeeper/kzk$i.leap.local"
#     /usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/zookeeper$i.keytab zookeeper/kzk$i.leap.local"
# done


gen_truststore() {
  openssl req -new -x509 -keyout $DIRECTORY/tls/ca-key -out $DIRECTORY/tls/ca-cert -days $VALIDITY -subj "/C=US/ST=Iowa/L=Iowa City/O=ACT/OU=Org/CN=trust" -passout pass:$SSL_PASSWORD
  keytool -keystore $DIRECTORY/tls/trust.jks -alias CARoot -import -file $DIRECTORY/tls/ca-cert -storepass $SSL_PASSWORD -noprompt -v
}

gen_keystore() {
  # keystone creation
  keytool -genkey -alias $1 -keyalg RSA -keystore $DIRECTORY/tls/$1.keystore.jks -dname "CN=$1, OU=leap, O=ACT, L=Iowa City, S=Iowa, C=US" -storepass $SSL_PASSWORD -keypass $SSL_PASSWORD

  #Certificate signing request CSR creation
  keytool -keystore $DIRECTORY/tls/$1.keystore.jks -alias $1 -certreq -file $DIRECTORY/tls/$1.cert-file -storepass $SSL_PASSWORD -keypass $SSL_PASSWORD

  # generate signed request
  openssl x509 -req -CA $DIRECTORY/tls/ca-cert -CAkey $DIRECTORY/tls/ca-key -in $DIRECTORY/tls/$1.cert-file -out $DIRECTORY/tls/$1.cert-signed -days $VALIDITY -CAcreateserial -passin pass:$SSL_PASSWORD

  #import signed certificate to keystore
  keytool -keystore $DIRECTORY/tls/$1.keystore.jks -alias CARoot -import -file $DIRECTORY/tls/$1.cert-signed -keypass $SSL_PASSWORD -storepass $SSL_PASSWORD -no-prompt
}

DOMAIN_C=`echo $DOMAIN | tr a-z A-Z`
HOST=`hostname -s`

sed -i "s/EXAMPLE.COM/$DOMAIN_C/g" /etc/krb5kdc/kdc.conf

sed -i "s/#ADD_SUB#/$ADD_SUB/g" /etc/krb5.conf

sed -i "s/#NAMESPACE#/$NAMESPACE/g" /etc/krb5.conf
 
sed -i "s/#HOST#/$HOST/g" /etc/krb5.conf

sed -i "s/#DOMAIN#/$DOMAIN/g" /etc/krb5.conf

sed -i "s/#DOMAIN_C#/$DOMAIN_C/g" /etc/krb5.conf

cp /etc/krb5.conf $DIRECTORY/krb5.conf

/usr/sbin/kdb5_util -P changeme create -s
mkdir -p $DIRECTORY/{keytabs,tls}
gen_truststore

for var in "$@"; do
  /usr/sbin/kadmin.local -q "addprinc -randkey $var/$var.$NAMESPACE$ADD_SUB$DOMAIN"
  /usr/sbin/kadmin.local -q "ktadd -k $DIRECTORY/keytabs/$var.keytab $var/$var.$NAMESPACE$ADD_SUB$DOMAIN"
  gen_keystore $var
done

/usr/sbin/krb5kdc -n