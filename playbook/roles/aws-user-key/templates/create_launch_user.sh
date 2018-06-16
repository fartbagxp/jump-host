#!/bin/bash
useradd -m {{ launch_user }}
mkdir -p ~{{ launch_user }}/.ssh
touch ~{{ launch_user }}/.ssh/authorized_keys
echo "{{ launch_user_authorized_keys }}" >> ~{{ launch_user }}/.ssh/authorized_keys
chown -R {{ launch_user }}:{{ launch_user_group }} ~{{ launch_user }}/.ssh
chmod -R u=rwX,go= ~{{ launch_user }}/.ssh
echo "%{{ launch_user }} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/{{ launch_user }}
