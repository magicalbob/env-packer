node default {
  exec { 'cmd.exe /c puppet module install puppetlabs-windows':
    path => $::path
  }

  exec { 'cmd.exe /c puppet module install puppet-archive':
    path => $::path
  }
}
