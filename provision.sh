#!/usr/bin/env bash

sudo aptitude update
sudo aptitude upgrade -y
sudo aptitude install golang -y

mkdir /home/vagrant/gocode

cat >> /home/vagrant/.bashrc << 'EOF'
export GOPATH=/home/vagrant/gocode
export PATH=$PATH:$GOPATH/bin
EOF

export GOPATH=/home/vagrant/gocode
export PATH=$PATH:$GOPATH/bin

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
