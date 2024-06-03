#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo "Illegal number of parameters. Parameters should equal or greater than 1" >&2
    exit 1
fi

# this will create WSL using root login.
# the following create a new user and set it as default user
username=$1
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
