#
# systemd::set_service_value
# ==========================
# Little helper script around ini_setting so the init.pp doesn't get so ugly
define systemd::set_service_value(
  $path,
  $section,
  $setting,
  $value
){

  $ensure = $value ? {
    'absent' => 'absent',
    undef    => 'absent',
    default  => 'present'
  }

  ini_setting{"${path}-${section}-${setting}-${value}":
    ensure  => $ensure,
    path    => $path,
    section => $section,
    setting => $setting,
    value   => $value,
    notify  => Exec['systemctl-daemon-reload']
  }

}
