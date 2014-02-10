#
# systemd::set_unit
# =====================
#
# All documentation below is taken from the manpage of systemd.unit
#
# $section_label: should usually stay the default
# $path: This is the path to the file you're setting up
#
# All other options should be directly from the systemd.unit documentation
#  unit_ is prepended to get around reserved params like 'before'
define systemd::set_unit(
  $section_label             = 'Unit',
  $path                      = undef,
  $unit_description          = undef,
  $unit_documentation        = undef,
  $unit_requires             = undef,
  $unit_requiresoverridable  = undef,
  $unit_requisite            = undef,
  $unit_requisiteoverridable = undef,
  $unit_wants                = 'basic.target',
  $unit_bindsto              = undef,
  $unit_before_unit          = undef,
  $unit_after                = 'basic.target network.target',
  $unit_onfailure            = undef,
  $unit_propagatesreloadto   = undef,
  $unit_reloadpropagatesfrom = undef,
  $unit_joinesnamespaceof    = undef,
  $unit_requiresmountsfor    = undef,
  $unit_onfailurejobmode     = undef,
  $unit_ignoreonisolate      = undef,
  $unit_ignoreonsnapshot     = undef,
  $unit_stopwhenunneeded     = undef,
  $unit_refusemanualstart    = undef,
  $unit_refusemanualstop     = undef,
  $unit_jobtimeoutsec        = undef,
  $unit_sourcepath           = undef
){

  unless $path {
    fail('path required for systemd::set_unit')
  }

  if $unit_description {
    validate_string($unit_description)
  }
  systemd::set_value{"${path}-unit-description":
    path    => $path,
    section => $section_label,
    setting => 'Description',
    value   => $unit_description
  }

  if $unit_documentation {
    validate_string($unit_documentation)
  }
  systemd::set_value{"${path}-unit-documentation":
    path    => $path,
    section => $section_label,
    setting => 'Documentation',
    value   => $unit_documentation
  }

  systemd::set_value{"${path}-unit-wants":
    path    => $path,
    section => $section_label,
    setting => 'Wants',
    value   => $unit_wants
  }

  systemd::set_value{"${path}-unit-after":
    path    => $path,
    section => $section_label,
    setting => 'After',
    value   => $unit_after
  }

  ## TODO:  Finish adding all of the above params

}
