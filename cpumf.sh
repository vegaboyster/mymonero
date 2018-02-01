#!/bin/bash
dnf -y update
dnf -y install mc gcc gcc-c++ cmake hwloc-devel libmicrohttpd-devel openssl-devel rapidjson-devel git screen
git clone https://github.com/fireice-uk/xmr-stak.git
sysctl -w vm.nr_hugepages=128
echo "* soft memlock 262144" >> /etc/security/limits.conf
echo "* hard memlock 262144" >> /etc/security/limits.conf
cd xmr-stak
cmake . -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF
make
cp bin/xmr-stak /usr/local/bin
cd ~
rm -Rf xmr-stak cpumf.sh
