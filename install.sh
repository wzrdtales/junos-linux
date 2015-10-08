#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: install.sh vpn.your.domain [default gateway]"
  exit 1
fi

if [ ! -f ncLinuxApp.jar ]; then
 echo "Can't find ncLinuxApp.jar"
 echo "Go to http://$1 and login into the platform"
 echo "After you've logged in you can download http://$1/dana-cached/nc/ncLinuxApp.jar"
 echo "After downloading place this jar in this folder!"
fi


if [ ! -f /usr/bin/apt ]; then
  echo "This script is made for debian or debian based OS. You need to adapt it if you're from another platform!"
  exit 1
fi

echo "Please login to your sudo rights, we need to install some packages!"
sudo -k
sudo -v

# Install packages
sudo apt-get install git gcc-multilib unzip curl -y

mkdir -p ~/.juniper_networks/network_connect

cp ncLinuxApp.jar junos_route ~/.juniper_networks/network_connect
cd ~/.juniper_networks/network_connect
git clone https://github.com/russdill/juniper-vpn-py.git
mv juniper-vpn-py/* .
rm -Rf juniper-vpn-py
unzip ncLinuxApp.jar
gcc -m32 -Wl,-rpath,`pwd` -o ncui libncui.so
chmod +x ncui ncdiag ncsvc
chmod +x getx509certificate.sh


if [ ! -f corp_junos.crt ]; then

  echo "We now download the certificate from $1:443"
  echo "If this does not work, for example if you're behind a proxy..., you can place the cert manually here `pwd`/corp_junos.crt"
  ./getx509certificate.sh "$1" "corp_junos.crt"
fi

if [ ! -z "$2" ]; then
  echo "#!/bin/bash

echo \"Replacing gateway $1\"

ip route del 0.0.0.0/1 via \"$1\"
ip route add 10.0.0.0/8 via \"$1\"
ip route add 172.16.0.0/12 via \"$1\"
ip route add 192.168.0.0/16 via \"$1\"" > junos_route
fi

chmod +x junos_route
sudo chown root:root ncui ncdiag ncsvc junos_route
sudo chmod 4755 ncui ncdiag ncsvc junos_route
sudo cp junos_route /usr/local/sbin/
sudo rm junos_route

echo "#!/bin/bash

if [ -z \"\$1\" ]; then
  echo \"Usage: junos_start username\"
  exit 1
fi

`pwd`/juniper-vpn.py --host $1 --user \$1 --stdin DSID=%DSID% sudo `pwd`/ncui -h %HOST% -f `pwd`/corp_junos.crt -c DSID=%DSID%" > junos_start

sudo chmod +x junos_start
sudo chown root:root junos_start
sudo chmod 4755 junos_start
sudo mv junos_start /usr/local/sbin/

cd -
