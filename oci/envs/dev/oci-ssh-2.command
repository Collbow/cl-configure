#!/bin/sh
# Copyright © 2020-2021 Collbow All Rights Reserved

SCRIPT_DIR=$(dirname "$0")
cd "${SCRIPT_DIR}"

IP_ADDRESS=$(terraform output instance_public_ips \
    | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' -o | sed -n 2p)

cd "${SCRIPT_DIR}"
ssh ${IP_ADDRESS} -i "../../../keys/ssh-key" -l "ubuntu"
