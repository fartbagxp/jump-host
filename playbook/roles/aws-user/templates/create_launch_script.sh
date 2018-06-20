#!/bin/bash

groupadd {{ launch_user_group }}
echo "%{{ launch_user_group }} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

OIFS=$IFS
IFS=","

read -r -a keys <<< "{{ joined_keys }}"
users=({{ usernames|join(" ")}})

for i in "${!users[@]}";
do
    useradd -G {{ launch_user_group }} ${users[i]}
    mkdir -p /home/${users[i]}/.ssh
    touch /home/${users[i]}/.ssh/authorized_keys
    echo "${keys[i]}" >> /home/${users[i]}/.ssh/authorized_keys
    chown -R ${users[i]}:{{ launch_user_group }} /home/${users[i]}/.ssh
    chmod -R u=rwX,go= /home/${users[i]}/.ssh
    echo "%${users[i]} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${users[i]}
done

IFS=$OIFS;