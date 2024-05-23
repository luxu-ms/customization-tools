#!/usr/bin/env bash

# wsl --install -d Ubuntu-22.04
# this will create WSL using root login.
# the following create a new user and set it as default user
username=lyle
if ! grep -q $username /etc/passwd; then
    NEWUSER=$username
    sudo useradd --create-home --shell /usr/bin/bash --user-group --groups  adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev --password $(read -sp Password: pw ; echo $pw | openssl passwd -1 -stdin) $NEWUSER

    cat <<EOF | sudo tee -a /etc/wsl.conf

[user]
default=$username

EOF
fi

cat <<EOF | sudo tee -a /etc/wsl.conf

[interop]
appendWindowsPath = false

EOF

# install dev dependencies
sudo apt update

sudo apt install -y zsh \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev \
    unzip language-pack-en openjdk-21-jdk-headless

# no password for sudo
echo "menxiao ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/menxiao
sudo chmod 0600 /etc/sudoers.d/menxiao

# install nvm for Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# install pyenv for Python
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src

# maven
MAVEN_URL="$(curl -sL "https://maven.apache.org/download.cgi" | grep -m1 -oP 'https://[^"]+/apache-maven-[\d\.]+-bin.tar.gz')"
MAVEN_FOLDER="$(grep -oP 'apache-maven-[\d\.]+' <<<"$MAVEN_URL")"
cd /opt/maven && curl -sLo- "$MAVEN_URL" | sudo tar zxf -
sudo ln -sfn "$MAVEN_FOLDER" current

cd

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

