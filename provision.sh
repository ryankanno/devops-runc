#!/usr/bin/env bash

sudo aptitude update
sudo aptitude upgrade -y
sudo aptitude install python-ipaddr python-protobuf libprotobuf-c1 golang -y

cd /tmp

wget http://http.us.debian.org/debian/pool/main/c/criu/criu_1.5.2-1_amd64.deb

sudo dpkg -i criu_1.5.2-1_amd64.deb

mkdir /home/vagrant/gocode

cat >> /home/vagrant/.bashrc << 'EOF'
export GOPATH=/home/vagrant/gocode
export PATH=$PATH:$GOPATH/bin
EOF

export GOPATH=/home/vagrant/gocode
export PATH=$PATH:$GOPATH/bin

cd $HOME
go get github.com/tools/godep
go get -d github.com/opencontainers/runc
cd $GOPATH/src/github.com/opencontainers/runc/
make
sudo make install

mkdir /home/vagrant/runc
cd /home/vagrant/runc
cp /usr/local/bin/runc .
cp /vagrant/container.json .
wget http://images.linuxcontainers.org/images/ubuntu/vivid/amd64/default/20150618_03:49/rootfs.tar.xz

mkdir rootfs
tar xf rootfs.tar.xz -C rootfs
