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
    unit_wants       => $wants,
    unit_after       => $after
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
