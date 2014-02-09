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
    path    => $service_file_path,
    section => 'Unit',
    setting => 'Description',
    value   => $description
  }

  systemd::set_unit{"${service}-wants":
    path    => $service_file_path,
    section => 'Unit',
    setting => 'Wants',
    value   => $wants
  }

  systemd::set_unit{"${service}-after":
    path    => $service_file_path,
    section => 'Unit',
    setting => 'After',
    value   => $after
  }

  systemd::set_service_value{"${service}-type":
    path    => $service_file_path,
    section => 'Service',
    setting => 'Type',
    value   => $type
  }

  systemd::set_service_value{"${service}-pidfile":
    path    => $service_file_path,
    section => 'Service',
    setting => 'PIDFile',
    value   => $pidfile
  }

  systemd::set_service_value{"${service}-execstart":
    path    => $service_file_path,
    section => 'Service',
    setting => 'ExecStart',
    value   => $execstart
  }

  systemd::set_service_value{"${service}-execstartpre":
    path    => $service_file_path,
    section => 'Service',
    setting => 'ExecStartPre',
    value   => $execstartpre
  }

  systemd::set_service_value{"${service}-execstop":
    path    => $service_file_path,
    section => 'Service',
    setting => 'ExecStop',
    value   => $execstop
  }

  systemd::set_service_value{"${service}-execstoppre":
    path    => $service_file_path,
    section => 'Service',
    setting => 'ExecStopPre',
    value   => $execstoppre
  }

  systemd::set_service_value{"${service}-execreload":
    path    => $service_file_path,
    section => 'Service',
    setting => 'ExecReload',
    value   => $execreload
  }

  systemd::set_service_value{"${service}-timeout":
    path    => $service_file_path,
    section => 'Service',
    setting => 'Timeout',
    value   => $timeout
  }

}
