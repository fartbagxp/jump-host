#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "Must supply a username: sh generate-QR.sh <username>"
    exit
fi

username=$1
code=$(echo $(credstash get $1) | head -n1 | awk '{print $1;}')

if [ -z "$code" ]
  then
    echo "No TOTP code found for user: $username."
    exit
fi

hostname="fartbagxp-jumpbox"

echo "QR code link generated:"
echo "https://www.google.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/$username@$hostname%3Fsecret%3D$code"