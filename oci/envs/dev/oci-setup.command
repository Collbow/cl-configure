#!/bin/sh
# Copyright © 2020-2021 Collbow All Rights Reserved

SCRIPT_DIR=$(dirname "$0")
cd "${SCRIPT_DIR}"

IPs=$(terraform output instance_public_ips \
    | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' -o)

for IP in ${IPs}; do
    scp -i "../../../keys/ssh-key" "../../../keys/Wallet_devadb.zip" ubuntu@${IP}:~/Wallet_devadb.zip
done

for IP in ${IPs}; do
ssh ${IP} -i "../../../keys/ssh-key" -l "ubuntu" <<EOC
    yes | sudo apt update
    yes | sudo apt install nginx
    yes | sudo apt install zip
    yes | sudo apt install unzip

    sudo iptables -I INPUT 5 -p tcp --dport 80 -j ACCEPT
    sudo "/etc/init.d/netfilter-persistent" save
    sudo "/etc/init.d/netfilter-persistent" reload

    sudo sed -i -e "s/Welcome to nginx!/Welcome to nginx(${IP})!/" "/var/www/html/index.nginx-debian.html"

    curl https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basic-linux.x64-21.1.0.0.0.zip --output "instantclient-basic-linux.x64-21.1.0.0.0.zip"
    curl https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-sqlplus-linux.x64-21.1.0.0.0.zip --output "instantclient-sqlplus-linux.x64-21.1.0.0.0.zip"
    sudo unzip "instantclient-basic-linux.x64-21.1.0.0.0.zip" -d "/usr/local/bin/"
    sudo unzip "instantclient-sqlplus-linux.x64-21.1.0.0.0.zip" -d "/usr/local/bin/"    
    sudo unzip -o "Wallet_devadb.zip" -d "/usr/local/bin/instantclient_21_1/network/admin/"

    echo "export PATH=$PATH:/usr/local/bin/instantclient_21_1" >> ".bash_profile"
    echo "export LD_LIBRARY_PATH=/usr/local/bin/instantclient_21_1" >> ".bash_profile"

    rm "instantclient-basic-linux.x64-21.1.0.0.0.zip"
    rm "instantclient-sqlplus-linux.x64-21.1.0.0.0.zip"
    rm "Wallet_devadb.zip"
EOC
done
