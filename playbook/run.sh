#!/bin/bash

ansible-playbook -i hosts --vault-password-file ${PWD}/.vault-pass.txt -vvvv terminate.yml

# This will provision a jump host with 2FA.
ansible-playbook -i hosts --vault-password-file ${PWD}/.vault-pass.txt -vvvv main.yml
