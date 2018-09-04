#!/usr/bin/env bash

ansible-playbook -i hosts --vault-password-file ${PWD}/.vault-pass.txt -vvvv main.yml
