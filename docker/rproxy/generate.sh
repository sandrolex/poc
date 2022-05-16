#!/bin/bash

rm -rf ./certs
mkdir ./certs
cd ./certs

# generate CA
openssl req -x509 -sha256 -days 3650 -newkey rsa:4096 -keyout rootCA.key -out rootCA.crt

# Generate a new private key for the server cert
openssl genrsa -out rproxy-server.key 4096


# Generate a CSR for the server cert
openssl req -new -key rproxy-server.key -subj "/CN=poc.entry" -addext "subjectAltName=DNS:poc.entry,DNS:localhost" -out rproxy-server.csr

cat <<EOF > rproxy_cert_ext.cnf
basicConstraints = CA:FALSE
nsCertType = server
nsComment = "OpenSSL Generated Server Certificate"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = poc.entry 
DNS.2 = localhost
EOF


# Sign the CSR with the CA cert
openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in rproxy-server.csr -out rproxy-server.crt -days 365 -CAcreateserial -extfile rproxy_cert_ext.cnf

openssl pkcs12 -export -out rproxy-server.pfx -inkey rproxy-server.key -in rproxy-server.crt -certfile rootCA.crt -name "rproxy"




