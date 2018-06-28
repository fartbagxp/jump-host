#!/bin/bash

FILES=$(find vault/ -type f -iname "*.yml*" ! -iname  "*sample.yml")
for line in $FILES; do 
  ansible-vault decrypt --vault-password-file ${PWD}/.vault-pass.txt "$line"
done