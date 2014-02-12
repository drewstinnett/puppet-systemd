#
# systemd::service_file
# =====================
# Manage a systemd service file
define systemd::service_file(
  $service      = $title,
  $description  = absent,
  $type         = absent,
  $restart      = absent,
  $execstart    = absent,
  $execstartpre = absent,
  $execstop     = absent,
  $execstoppre  = absent,
  $execreload   = absent,
  $wants        = 'basic.target',
  $after        = 'basic.target network.target',
  $pidfile      = absent,
  $timeout      = absent,
){

  ## Do some validation
  $valid_types = ['simple', 'forking', 'oneshot', 'dbus', 'notify', 'idle']
  if $type == absent {
    fail('type is required')
  }
  unless $type in $valid_types {
    fail('Unknown type, see docs for usage')
  }

  $valid_restarts = ['no', 'on-success', 'on-failure', 'on-watchdog',
                      'on-abort', 'always', absent]
  unless $restart in $valid_restarts {
    fail('Unknown restart, see docs for usage')
  }

  $types_requiring_execstart = ['simple', 'forking']
  if $type in $types_requiring_execstart {
    if $execstart == absent {
      fail("${type} requires execstart to be set")
    }
  }

  $service_file_path = "${systemd::system_directory}/${service}.service"

  file{"${service}.service":
    ensure  => file,
    path    => $service_file_path,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => File[$systemd::system_directory]
  }

  systemd::set_unit{"${service}-description":
    path        => $service_file_path,
    description => $description,
    wants       => $wants,
    after       => $after
  }

  systemd::set_exec{"${service}-exec":
    path              => $service_file_path,
    label             => 'Service',
    exec_type         => $type,
    exec_pidfile      => $pidfile,
    exec_execstart    => $execstart,
    exec_execstartpre => $execstartpre,
    exec_execstop     => $execstop,
    exec_execstoppre  => $execstoppre,
    exec_execreload   => $execreload,
    exec_timeout      => $timeout,
  }

}
