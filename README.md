# Systemd #

Set up and configure systemd files on a system.

**This is not for replacing the built in puppet service type, however it can
be used to generate $name.service files on the filesystem.**

## Quickstart ##

Service File Configuration

    include systemd
    systemd::service_file{'test':
      type    => 'oneshot',
      start   => '/bin/test start',
      stop    => '/bin/test stop',
      restart => '/bin/test restart',
      timeout => '50'
    }

Once this is in place, the 'splunk' service can be controled through systemctl
