#!bin/bash

sudo yum update -y

# Install Google PAM
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install google-authenticator

# Add required to Google PAM
# Add auth required pam_google_authenticator.so to last line
# Comment out -> auth	    substack     password-auth
sudo nano /etc/pam.d/sshd

# Change ChallengeResponse to yes
# Add AuthenticationMethods publickey,password publickey,keyboard-interactive to after ClientAlive Max 2
sudo nano /etc/ssh/sshd_config

# Restart ssh daemon
sudo /etc/init.d/sshd restart

# Install under <user>:
# -t = time-based (TOTP) verification
# -d = disallow reuse of TOTP token
# -f = without verification from user
# -r 3 -R 30 = rate limit 3 times every 30 seconds
# -w 17 = concurrently valid for last 17 codes (+-4 minutes) 
google-authenticator -t -d -f -r 3 -R 30 -w 17