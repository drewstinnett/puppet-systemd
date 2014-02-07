#
# systemd
# =======
# Manage systemd configuration
class systemd(
){

  $system_directory = '/usr/lib/systemd/system'

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
