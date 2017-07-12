node default {
  exec { 'puppetlabs-ntp':
    command => "puppet module install puppetlabs-ntl",
    unless  => "puppet module list | grep suppetlabs-ntp",
    path    => ['/bin', '/usr/bin']
  }
}
