# Class: firewall
# ===========================
#
# Full description of class firewall here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'firewall':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class firewall {
  resources { 'firewall':
    purge => true
  }

  firewallchain { 'INPUT:filter:IPv4':
    ensure => present,
    policy => drop,
    before => undef,
  }

  firewall { '001 accept all to lo interface':
    chain   => 'INPUT',
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept'
  }

  firewall { '002 accept related established rules':
    chain   => 'INPUT',
    proto   => 'all',
    state   => [ 'RELATED','ESTABLISHED' ],
    action  => 'accept'
  }

  firewall { '003 allow ssh':
    chain   => 'INPUT',
    proto   => 'tcp',
    state   => [ 'NEW' ],
    dport   => '22',
    action  => 'accept'
  }
}
