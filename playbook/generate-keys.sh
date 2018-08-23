#!/usr/bin/env bash

echo "Generating two users under the name user1 and user2..."
ssh-keygen -t rsa -b 4096 -f ~/.ssh/user1 -q -N ""
ssh-keygen -t rsa -b 4096 -f ~/.ssh/user2 -q -N ""

cp ~/.ssh/user1.pub $PWD/roles/aws-user/public-keys/
cp ~/.ssh/user2.pub $PWD/roles/aws-user/public-keys/

echo "Successfully generated users."