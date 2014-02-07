#
# systemd
# =======
# Manage systemd configuration
class systemd(
){

  case $::operatingsystem {
    'RedHat': {
      $system_directory = '/usr/lib/systemd/system'

      if $::operatingsystemmajorelease < 7 {
        fail('RedHat operating systems must be at least v7')
      }

    }

    default: {
      fail("${::operatingsystem} is not supported")
    }
  }


  file{$system_directory:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0644'
  }

  package{'systemd':
    ensure => installed
  }

}
