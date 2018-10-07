# Fail2ban

[Fail2ban](https://www.fail2ban.org/wiki/index.php/Main_Page) is a tool that scans log files and bans IP address(es) based on selective filter rules.

In short, it acts as a firewall against failed login attempts.

The focus of this document will be utilizing Fail2ban to secure a bastion host / jumpbox.

## How it works

Fail2ban takes a configuration called a jail and employs one of the following methods (pyinotify, gamin, polling) to periodically _filter_ log files (/var/log/secure && /var/log/messages) against [regular expressions](https://www.regular-expressions.info/). Upon identifying the matches, it will take an _action_ based on configurations.

An action usually result in an IP ban using an IP table rule sets for a period of time.

## Configuration

Fail2Ban uses three primary files for configuration.

A `jail.conf` file control the type of _jail_ to enable and the filters and actions to use.

A `filter.conf` file is a set of regular expressions to match against a logpath. Matches are sent to the action file.

A `action.conf` file can be a set of iptables commands to block particular traffic.

### Where you can find them

| Jail                     | Filter                   | Action                           |
| ------------------------ | ------------------------ | -------------------------------- |
| /etc/fail2ban/jail.local | /etc/fail2ban/filter.d/sshd.local | /etc/fail2ban/action.d/iptables-ssh.local |

### Iptables

Iptables is a user-space program used as a firewall in Linux systems. The tables in iptables consist of _chains_, lists of rules followed in order. Every chain has a unique name.

Fail2ban use names with prefixes of `f2b-` in iptables.
A Fail2ban action to drop all traffic from a particular IP address: `iptables -I f2b-<name> 1 -s <ip> -j DROP` requires the name of the chain to work with Fail2ban.

## Jails

This is a list of protection jails we have defined so far.

### SSH protection

SSH protection is one of the inherit defense jail that Fail2ban is known for. By default, the jail contains a ssh jail that will ban on multiple failure attempts to break into the bastion host.

### Geofence

Geofencing is a technique to minimize the attack surface based on IP address location. By combining an [IP location database](https://dev.maxmind.com/geoip/legacy/geolite/) with Fail2ban, the bastion host will see an decrease in surface area for scanning and attacks.

## Useful commands

- Debugging configuration files for fail2ban  
`sudo fail2ban-client -vvv -x start`

- List all [iptable rule set](https://wiki.archlinux.org/index.php/iptables), with packet/byte count  
`sudo iptables -v -x -n -L`

- Show all matches from the geofence filter. This is particularly useful in debugging regex.  
`sudo fail2ban-regex /var/log/secure /etc/fail2ban/filter.d/geoip-fence.local --print-all-matched`

## Log location

- What is the SSH daemon doing?  
*/var/log/secure*

- What is Fail2ban doing?  
*/var/log/fail2ban.log*