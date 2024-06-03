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

cat <<EOF | sudo tee -a /etc/sudoers.d/$username
$username ALL=(ALL) NOPASSWD:ALL
EOF
