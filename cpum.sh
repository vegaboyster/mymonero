#!/bin/bash
apt -y update
apt -y upgrade
apt -y install mc libmicrohttpd-dev libssl-dev cmake build-essential git screen libhwloc-dev
git clone https://github.com/fireice-uk/xmr-stak-cpu.git
sysctl -w vm.nr_hugepages=128
echo "* soft memlock 262144" >> /etc/security/limits.conf
echo "* hard memlock 262144" >> /etc/security/limits.conf
cd xmr-stak-cpu
cmake .
make
cp bin/xmr-stak-cpu /usr/local/bin
cp config.txt ~/tempconf.txt
cd ~
sed $'s/\r$//' tempconf.txt >config.txt
rm tempconf.txt
read -p "Enter pool password: " poolpassword
poolpassword=${poolpassword}
sed -i 's/"pool_address" : "pool.usxmrpool.com:3333",/"pool_address" : "pool.supportxmr.com:7777",/g' config.txt
sed -i 's/"wallet_address" : "",/"wallet_address" : "44QM2gXjRhFfLjFTZMGyc5CzGo61oznL1ZoLdfihwAqPPDk8Kp2jRxo6zQzTqh3Q1N2ytk5SHEpGfRZ9XwrV78hoBfFSahS",/g' config.txt
sed -i 's/"pool_password" : "",/"pool_password" : "'$poolpassword':vegaboyster@gmail.com",/g' config.txt
rm -Rf xmr-stak-cpu cpum.sh
