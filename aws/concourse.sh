#!/usr/bin/env bash

# MISCELLANEOUS

sudo apt update

#sudo apt install nginx -y

# Prevents Grub updating, which is causing an interupt.
sudo rm /boot/grub/menu.lst 
sudo update-grub-legacy-ec2 -y
#sudo apt-get dist-upgrade -qq --force-yes
#sudo reboot

sudo apt upgrade -y

# DOCKER

sudo apt install apt-transport-https \
                 ca-certificates \
                 curl \
                 gnupg-agent \
                 software-properties-common \
                 -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                        $(lsb_release -cs) \
                        stable"

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io -y

# DOCKER COMPOSE 

sudo curl -L https://github.com/docker/compose/releases/download/1.25.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# CONCOURSE

wget https://concourse-ci.org/docker-compose.yml

sudo docker-compose up -d