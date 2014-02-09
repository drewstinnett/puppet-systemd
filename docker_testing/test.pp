notify{'Testing systemd':}

include systemd
systemd::service_file{'test':
  type      => 'oneshot',
  execstart => '/bin/true'
}
