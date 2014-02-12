notify{'Testing systemd':}

include systemd
systemd::service_file{'test':
  type    => 'oneshot',
  start   => '/bin/true'
  stop    => '/bin/true'
  restart => '/bin/true'
  timeout => '50'
}
