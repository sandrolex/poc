#!/bin/bash

sudo rm -rf /usr/local/bin/*
sudo apt-get install -y docker.io git build-essential
sudo rm -rf ~/build 
mkdir ~/build && cd ~/build/
git clone https://github.com/docker/docker-ce.git
cd docker-ce
git checkout v18.03.1-ce
sudo make static DOCKER_BUILD_PKGS=static-linux
sudo dpkg --purge docker.io
sudo cp ~/build/docker-ce/components/packaging/static/build/linux/docker/* /usr/local/bin/
docker --version

