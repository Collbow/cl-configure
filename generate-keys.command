#!/bin/sh
# Copyright © 2020-2021 Collbow All Rights Reserved

SCRIPT_DIR=$(dirname "$0")
cd "${SCRIPT_DIR}"

mkdir -p "keys"

openssl genrsa -out "keys/oci_api_key.pem" 2048
openssl rsa -pubout -in "keys/oci_api_key.pem" -out "keys/oci_api_key_public.pem"

ssh-keygen -t rsa -b 2048 -N "" -f "keys/ssh-key"

openssl genrsa -out "keys/ca_key.pem" 2048
openssl req -new -key "keys/ca_key.pem" -out "keys/ca_cert.csr"
openssl x509 -req -days 825 -in "keys/ca_cert.csr" -signkey "keys/ca_key.pem" -out "keys/ca_cert.pem"
