#
# systemd::service_file
# =====================
#
# All documentation below is taken from the manpage of systemd.unit
#
# $section_label: should usually stay the default
# $path: This is the path to the file you're setting up
#
# All other options should be directly from the systemd.unit documentation
define systemd::set_unit(
  $section_label        = 'Unit',
  $path                 = undef,

  $description          = undef,
  $documentation        = undef,
  $requires             = undef,
  $requiresoverridable  = undef,
  $requisite            = undef,
  $requisiteoverridable = undef,
  $wants                = 'basic.target',
  $bindsto              = undef,
  ## before is reserved
  $before_unit          = undef,
  $after                = 'basic.target network.target',
  $onfailure            = undef,
  $propagatesreloadto   = undef,
  $reloadpropagatesfrom = undef,
  $joinesnamespaceof    = undef,
  $requiresmountsfor    = undef,
  $onfailurejobmode     = undef,
  $ignoreonisolate      = undef,
  $ignoreonsnapshot     = undef,
  $stopwhenunneeded     = undef,
  $refusemanualstart    = undef,
  $refusemanualstop     = undef,
  $jobtimeoutsec        = undef,
  $sourcepath           = undef
){

  unless $path {
    fail('path required for systemd::set_unit')
  }

  if $description {
    validate_string($description)
  }
  systemd::set_service_value{"${path}-unit-description":
    path    => $path,
    section => $section_label,
    setting => 'Description',
    value   => $description
  }

  if $documentation {
    validate_string($documentation)
  }
  systemd::set_service_value{"${path}-unit-documentation":
    path    => $path,
    section => $section_label,
    setting => 'Documentation',
    value   => $documentation
  }

  systemd::set_service_value{"${path}-unit-wants":
    path    => $path,
    section => $section_label,
    setting => 'Wants',
    value   => $wants
  }

  systemd::set_service_value{"${path}-unit-after":
    path    => $path,
    section => $section_label,
    setting => 'After',
    value   => $after
  }

}
