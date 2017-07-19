node default {
  include ntp
  include hosts

  yumrepo { 'lynis':
    baseurl => 'https://packages.cisofy.com/community/lynis/rpm/
',
    descr => 'CISOfy Software - Lynis package',
    enabled => 1,
    gpgcheck => 1,
    gpgkey => 'https://packages.cisofy.com/keys/cisofy-software-rpms-public.key'
  }

  yum::install { 'lynis':
    ensure => present,
    source => 'lynis'
  }

  cron { 'lynis audit system':
    command => '/bin/lynis audit system',
    user    => 'root',
    hour    => 2,
    minute  => 0,
  }
}
