node default {
  class { 'ntp':
    servers => ['0.uk.pool.ntp.org','1.uk.pool.ntp.org','2.uk.pool.ntp.org','3.uk.pool.ntp.org']
  }

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
}
