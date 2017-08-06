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

  exec { 'puppetlabs-firewall':
    command => "puppet module install puppetlabs-firewall",
    unless  => "puppet module list | grep puppetlabs-firewall",
    path    => ['/bin', '/usr/bin', '/opt/puppetlabs/bin']
  }

  exec { 'saz-sudo':
    command => "puppet module install saz-sudo",
    unless  => "puppet module list | grep saz-sudo",
    path    => ['/bin', '/usr/bin', '/opt/puppetlabs/bin']
  }
}
