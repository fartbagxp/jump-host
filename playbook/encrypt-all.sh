#!/bin/bash

FILES=$(find vault/ -type f -name "*.yml")
for line in $FILES; do 
  ansible-vault encrypt --vault-password-file ${PWD}/.vault-pass.txt "$line"
done