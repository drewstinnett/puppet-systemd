#
# systemd::service_file
# =====================
# Manage a systemd service file
define systemd::service_file(
  $execstart    = absent,
  $execstartpre = absent,
  $execstop     = absent,
  $execstoppre  = absent,
  $execreload   = absent,
  $service      = $title,
  $description  = absent,
  $type         = absent,
  $pidfile = absent,
  $timeout = absent,
  $wants = 'basic.target',
  $after = 'basic.target network.target'
){

  $service_file_path = "${systemd::system_directory}/${service}.service"

  if $execstart == 'absent' {
    fail('Be sure to include the command to start the service (execstart)')
  }

  exec{'systemctl-daemon-reload':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true
  }

  file{"${service}.service":
    ensure  => file,
    path    => $service_file_path,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => File[$systemd::system_directory]
  }

  systemd::set_service_value{"${service}-description":
    path    => $service_file_path,
    section => 'Unit',
    setting => 'Description',
    value   => $description
  }

  systemd::set_service_value{"${service}-wants":
    path    => $service_file_path,
    section => 'Unit',
    setting => 'Wants',
    value   => $wants
  }

  systemd::set_service_value{"${service}-after":
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
