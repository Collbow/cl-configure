#!/bin/sh
# Copyright © 2020-2021 Collbow All Rights Reserved

SCRIPT_DIR=$(dirname "$0")
cd "${SCRIPT_DIR}"

VERSION=0.14.4

EXEC_DIR="${SCRIPT_DIR}/exec"
mkdir -p "${EXEC_DIR}"

cd "${EXEC_DIR}"
if [[ -e "terraform" ]]; then
    rm "terraform"
fi

curl -sL https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_darwin_amd64.zip > terraform.zip
unzip terraform.zip
rm terraform.zip

if [ ! "`echo ${PATH} | grep "":${EXEC_DIR}""`" ]; then
    if [[ -e "${HOME}/.zshenv" ]]; then
        sed -e "/^export PATH=/d" "${HOME}/.zshenv" -i
    fi
    echo "export PATH=${PATH}:${EXEC_DIR}" >> "${HOME}/.zshenv"
fi
