### Kerberos standalone

This docker container starts up a KDC server. It also generates tls certs for the principals.

The command listed in the docker container is used to start KDC server, generates certs and keytabs.

certs are generated in `<SECURITY_DIRECTORY>/tls/`

keytabs are generated in `<SECURITY_DIRECTORY>/keytabs/`

#### Command 

`/tmp/run.sh -v <TLS VALIDITY PERIOD> -d <SECURITY DIRECTORY> <principal_1> <principal_2> ... <principal_n>`

#### Pull image
` docker pull sridhav/kerberos`

#### Run spark (interactive mode)
` docker run -p 88:7088 -it sridhav/kerberos`

#### Run spark (detached mode)
` docker run -p 88:7088 -d -t sridhav/kerberos`
