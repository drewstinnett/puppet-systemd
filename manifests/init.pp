#
# systemd
# =======
# Manage systemd configuration
class systemd(
){

  case $::operatingsystem {
    'RedHat': {

      if versioncmp($::operatingsystemrelease, '7.0') < 0 {
        fail('RedHat operating systems must be at least v7')
      }

    }

    'Fedora': {

      if versioncmp($::operatingsystemrelease, '15.0') < 0 {
        fail('Fedora operating systems must be at least v15')
      }

    }

    default: {
      fail("${::operatingsystem} is not supported")
    }
  }

  $system_directory = '/etc/systemd/system'

  ensure_packages(['systemd'])

  file{$system_directory:
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['systemd']
  }

  exec{'systemctl-daemon-reload':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true
  }

}
