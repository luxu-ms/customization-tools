#!/usr/bin/env bash

# this will create WSL using root login.
# the following create a new user and set it as default user
username=lyle
if ! grep -q $username /etc/passwd; then
    NEWUSER=$username
    sudo useradd --create-home --shell /usr/bin/bash --user-group --groups  adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev --password $(echo '' | openssl passwd -1 -stdin) $NEWUSER

    cat <<EOF | sudo tee -a /etc/wsl.conf

[user]
default=$username

EOF
fi

cat <<EOF | sudo tee -a /etc/wsl.conf

[interop]
appendWindowsPath = false

EOF

# no password for sudo
cat <<EOF | sudo tee -a /etc/sudoers.d/$username
$username ALL=(ALL) NOPASSWD:ALL
EOF

# install dev dependencies
sudo apt update

sudo apt install -y zsh \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev \
    unzip language-pack-en openjdk-21-jdk-headless

# install nvm for Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# install pyenv for Python
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src

# Splunk
cd ~
wget -O splunk-9.2.1-78803f08aabb-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.2.1/linux/splunk-9.2.1-78803f08aabb-Linux-x86_64.tgz"
tar xvzf splunk-9.2.1-78803f08aabb-Linux-x86_64.tgz
sudo mv splunk /opt/
echo 'export SPLUNK_HOME=/opt/splunk' >> ~/.bashrc 
source ~/.bashrc
cd /opt/splunk/bin
sudo ./splunk start --accept-license --answer-yes --no-prompt --seed-passwd Welcome1
sudo ./splunk enable boot-start
