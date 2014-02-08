#
# systemd
# =======
# Manage systemd configuration
class systemd(
){

  case $::operatingsystem {
    'RedHat': {
      $system_directory = '/usr/lib/systemd/system'

      if versioncmp($::operatingsystemrelease, '7.0') < 0 {
        fail('RedHat operating systems must be at least v7')
      }

    }

    default: {
      fail("${::operatingsystem} is not supported")
    }
  }

  ensure_packages(['systemd'])

  file{$system_directory:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0644'
  }

}
