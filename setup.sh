#!/usr/bin/env bash

# Update the things

sudo apt-get update -y
sudo apt-get install -y \
	bash-completion \
	command-not-found \
	build-essential \
	git \
	perl-tk

sudo apt-get upgrade -y

# Get wifi kernel https://devtalk.nvidia.com/default/topic/795734/-customkernel-the-grinch-21-2-1-for-jetson-tk1-not-developed/

wget http://www.jarzebski.pl/files/jetsontk1/grinch-21.2.1/zImage
wget http://www.jarzebski.pl/files/jetsontk1/grinch-21.2.1/jetson-tk1-grinch-21.2.1-modules.tar.bz2
wget http://www.jarzebski.pl/files/jetsontk1/grinch-21.2.1/jetson-tk1-grinch-21.2.1-firmware.tar.bz2

sudo tar -C /lib/modules -vxjf jetson-tk1-grinch-21.2.1-modules.tar.bz2
sudo tar -C /lib -vxjf jetson-tk1-grinch-21.2.1-firmware.tar.bz2
sudo cp zImage /boot/zImage

# Add swap https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04

sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

echo '/swapfile   none    swap    sw    0   0' | sudo tee -a /etc/fstab
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf

# Show temperatures

./showTemp.pl

# Install caffe http://planspace.org/20150614-the_nvidia_jetson_tk1_with_caffe_on_mnist/

sudo apt-get install \
    libprotobuf-dev protobuf-compiler gfortran \
    libboost-dev cmake libleveldb-dev libsnappy-dev \
    libboost-thread-dev libboost-system-dev \
    libatlas-base-dev libhdf5-serial-dev libgflags-dev \
    libgoogle-glog-dev liblmdb-dev python-numpy

git clone https://github.com/BVLC/caffe.git
cd caffe
cp Makefile.config.example Makefile.config

make -j 4 all

# Test Caffe

make -j 4 test
make -j 4 runtest

run build/tools/caffe time --model=models/bvlc_alexnet/deploy.prototxt --gpu=0
# I get ~27s

# Restart
sudo reboot
