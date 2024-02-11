#!/bin/bash

# credentials 
a=$(zenity --password --username --title="Ubuntu credentials")
u_cred=(${a//\|/ })
# Docker installation
echo ${u_cred[1]} | sudo -S apt update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Nvidia instalation
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker



# Add user to docker
sudo adduser ${u_cred[0]} docker
#newgrp docker

echo "Github selected"
server="ghcr.io"
msg='Github Personal Token'
# credentials 
a=$(zenity --password --username --title=$msg)
g_cred=(${a//\|/ })

/usr/bin/newgrp docker <<EONG
    docker login --username ${g_cred[0]} --password ${g_cred[1]} ${server}
EONG



# create docker mounts directory
distro_name=$(zenity --entry --title="Docker name" --text="Choose a docker name (example: my_docker, custom_dock, etc)")
mkdir -p ~/docker_mounts/$distro_name/exchange
mkdir -p ~/exchange

cd ~

# Docker utils script nedded now
docker_link=$(zenity --entry --title="Dockerlink" --text="Paste here the docker registry link")

# Copy .bashrc config
cp ~/.bashrc ~/docker_mounts/$distro_name/

cd ~
echo "force_color_prompt=yes" >> ~/docker_mounts/$distro_name/.bashrc
echo "alias $distro_name='docker start $distro_name && docker attach $distro_name'" >> .bashrc
# Add docker name in terminal header
echo $"PS1='\\033[01;91m$distro_name docker \\033[0m'\$PS1" >> $HOME/docker_mounts/$distro_name/.bashrc

/usr/bin/newgrp docker <<EONG
docker pull $docker_link
source ~/upc_planning/docker_run_command.sh -d -it -v /home/${u_cred[0]}/docker_mounts/$distro_name:/home/user -v /home:/home --name $distro_name $docker_link
EONG

if zenity --question --text="Installation complete! Reboot needed. Do you want to reboot now?"
then 
    sudo reboot
fi


