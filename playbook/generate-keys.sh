#!/usr/bin/env bash

echo "Generating two users under the name user1 and user2..."
ssh-keygen -t rsa -b 4096 -f ~/.ssh/user1 -q -N ""
ssh-keygen -t rsa -b 4096 -f ~/.ssh/user2 -q -N ""

# copy the keys to the ansible roles
cp ~/.ssh/user1.pub $PWD/roles/aws-user/public-keys/
cp ~/.ssh/user2.pub $PWD/roles/aws-user/public-keys/

# add the keys to ssh agent
ssh-add ~/.ssh/user1
ssh-add ~/.ssh/user2

echo "Successfully generated users."