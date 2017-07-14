node default {
  exec { 'puppetlabs-ntp':
    command => "puppet module install puppetlabs-ntp",
    unless  => "puppet module list | grep puppetlabs-ntp",
    path    => ['/bin', '/usr/bin', '/opt/puppetlabs/bin']
  }

  exec { 'puppet-yum':
    command => "puppet module install puppet-yum",
    unless  => "puppet module list | grep puppet-yum",
    path    => ['/bin', '/usr/bin', '/opt/puppetlabs/bin']
  }
}
