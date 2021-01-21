#!/bin/sh
# Copyright © 2020-2021 Collbow All Rights Reserved

SCRIPT_DIR=$(dirname "$0")
cd "${SCRIPT_DIR}"

terraform init
terraform apply
