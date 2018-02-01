#!/bin/bash
apt -y update
apt -y upgrade
apt -y install mc libmicrohttpd-dev libssl-dev cmake build-essential git screen libhwloc-dev
git clone https://github.com/fireice-uk/xmr-stak.git
sysctl -w vm.nr_hugepages=128
echo "* soft memlock 262144" >> /etc/security/limits.conf
echo "* hard memlock 262144" >> /etc/security/limits.conf
cd xmr-stak
cmake . -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF
make
cp bin/xmr-stak /usr/local/bin
cd ~
rm -Rf xmr-stak cpum.sh
