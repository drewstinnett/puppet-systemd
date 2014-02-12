#
# systemd::service_file
# =====================
# Manage a systemd service file
# This is more of a helper wrapper for systemd::set_exec, with the most common
# options set up
define systemd::service_file(
  $service     = $title,
  $description = absent,
  $type        = absent,
  $restart     = absent,
  $start       = absent,
  $stop        = absent,
  $reload      = absent,
  $pidfile     = absent,
  $timeout     = absent,
){

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
    path             => $service_file_path,
    unit_description => $description,
  }

  systemd::set_exec{"${service}-exec":
    path                 => $service_file_path,
    label                => 'Service',
    service_type         => $type,
    service_pidfile      => $pidfile,
    service_execstart    => $start,
    service_execstop     => $stop,
    service_execreload   => $reload,
    service_timeoutsec   => $timeout,
  }

}
