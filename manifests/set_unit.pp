#
# systemd::service_file
# =====================
# Manage a systemd service file
define systemd::set_unit(
  $description   = absent,
  $path          = absent,
  $section_label = 'Unit',
  $wants         = 'basic.target',
  $after         = 'basic.target network.target',
){

  if $path == absent {
    fail('path required for systemd::set_unit')
  }

  systemd::set_service_value{'unit-description':
    path    => $path,
    section => $section_label,
    setting => 'Description',
    value   => $description
  }

  systemd::set_service_value{'unit-wants':
    path    => $path,
    section => $section_label,
    setting => 'Wants',
    value   => $wants
  }

  systemd::set_service_value{'unit-after':
    path    => $path,
    section => $section_label,
    setting => 'After',
    value   => $after
  }

}
