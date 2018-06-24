# Overview

Most servers in the world are not exposed to the internet. Some of my servers and likely yours too, are hidden away, in a basement or maybe behind a cloud service (like AWS, or Digital Ocean, etc).

Sometimes, we need secured access to these servers through a publicly exposed intermediary such as a [jump host / bastion host](https://docs.aws.amazon.com/quickstart/latest/linux-bastion/architecture.html) to access these internal systems.

This is an example of a jump host / bastion with an attempt on secure hardening and supports Google PAM.

## Setup

1. Install [credstash](https://github.com/fugue/credstash)

```sh
virtualenv .
source ./bin/activate
pip install ansible
```

## Files to be aware of

1. `/etc/pam.d/sshd` is the Google PAM SSH daemon configuration.
1. `/etc/ssh/sshd_config` is the SSH daemon configuration.
1. `~/.google-authenticator` or `/home/<user>/.google_authenticator` is the secret key file for the local user's Google PAM.

## High Level

Let's prototype how to build something like this.

1. A simple instance supporting SSH key + Google PAM for multiple user.
1. Every time a new user is added, redeploy the jump host.
1. Every time a user is removed, redeploy the jump host.
1. Only generate the user's PAM if it's not among the files within the box.

## Details

1. Setup the server with SSH access for every user provided public key.
1. Pull [credstash](https://github.com/fugue/credstash) for all available <user,PAM auth> pair.
1. Restore available PAM pair onto the server.
1. Generate new PAM pair for new users without PAM pair.
1. Store new PAM pairs into [credstash](https://github.com/fugue/credstash).

## Questions to Answer

1. `How to Recover?` Delete the user and recreate a new user.

1. `Where to store Google PAM file?` Probably S3, and encrypted at REST with the key in AWS KMS.

1. `Is it okay for everybody on the team to know another person's PAM?` This is because when the files generated are stored in the jump host itself, and the person who ran the update will have access to all new users' PAM. 


## TODO

1. User group (don't use ec2-user)

1. Use credstash for PAM generated credentials.

## Resources

* [Securing SSH on Amazon Linux](https://aws.amazon.com/blogs/startups/securing-ssh-to-amazon-ec2-linux-hosts/)

* [Managing Users from AWS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/managing-users.html)

* [Integrating Redhat with Google Authenticator](https://github.com/google/google-authenticator)

* [Integrating Google PAM to CentOS](https://www.digitalocean.com/community/tutorials/how-to-set-up-multi-factor-authentication-for-ssh-on-centos-7#step-1-%E2%80%94-installing-google's-pam)

* [Google Authenticator Guide](https://wiki.archlinux.org/index.php/Google_Authenticator)