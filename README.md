# Overview

Most servers in the world are not exposed to the internet. Some of my servers and likely yours too, are hidden away, in a basement or maybe behind a cloud service (like AWS, or Digital Ocean, etc).

Sometimes, we need secured access to these servers through a publicly exposed intermediary such as a [jump host / bastion host](https://docs.aws.amazon.com/quickstart/latest/linux-bastion/architecture.html) to access these internal systems.

This is an example of a jump host / bastion with an attempt on secure hardening and supports Google PAM.

## Files to be aware of

1. `/etc/pam.d/sshd` is the Google PAM SSH daemon configuration.
1. `/etc/ssh/sshd_config` is the SSH daemon configuration.
1. `~/.google-authenticator` or `/home/<user>/.google_authenticator` is the secret key file for the local user's Google PAM.

## Prototype

Let's prototype how to build something like this.

1. A simple instance supporting SSH key + Google PAM for multiple user.
1. Every time a new user is added, redeploy the jump host.
1. Every time a user is removed, redeploy the jump host.
1. Only generate the user's PAM if it's not among the files within the box.

## Questions to Answer

1. `How to Recover?` Delete the user and recreate a new user.

1. `Where to store Google PAM file?` Probably S3, and encrypted at REST with the key in AWS KMS.

1. `

## Resources

* [Initial Server Setup from Digital Ocean](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04)

* [Managing Users from AWS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/managing-users.html)

* [Integrating Redhat with Google Authenticator](https://github.com/google/google-authenticator)

* [Integrating Google PAM to CentOS](https://www.digitalocean.com/community/tutorials/how-to-set-up-multi-factor-authentication-for-ssh-on-centos-7#step-1-%E2%80%94-installing-google's-pam)

* [Google Authenticator Guide](https://wiki.archlinux.org/index.php/Google_Authenticator)