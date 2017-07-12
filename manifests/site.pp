node default {
  exec { 'puppetlabs-ntp':
    command => "puppet module install puppetlabs-ntp",
    unless  => "puppet module list | grep puppetlabs-ntp",
    path    => ['/bin', '/usr/bin']
  }
}
