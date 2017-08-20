node default {
  include ntp
  include hosts
  include users
  include sshd
  include sudoers
  include firewall
  include lynis
}

node /^pipat-.*/ {
  network_config { 'eth0':
    ensure    => 'present',
    method    => 'static',
    onboot    => 'true',
    ipaddress => hiera('hosts')[$hostname]['ip'],
    netmask   => '255.255.255.0'
  }

  exec { 'network-restart':
    command => "systemctl restart network",
    path    => ['/bin','/usr/bin','/opt/puppetlabs/bin'],
    onlyif    => [
                   'which vmtoolsd'
                 ]
  }
}
