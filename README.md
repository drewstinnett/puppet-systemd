# Systemd #

Set up and configure systemd files on a system.

**This is not for replacing the built in puppet service type, however it can
be used to generate $name.service files on the filesystem.**

## Quickstart ##

Service File Configuration

    include systemd
    systemd::service{'test':
      type    => 'oneshot',
      start   => '/bin/test start',
      stop    => '/bin/test stop',
      restart => '/bin/test restart',
      timeout => '50'
    }

For more complete example, you can use systemd::set_exec.  This function has
the full set of commands that a service/exec type would use.  The
'systemd::service' is just a quick wrapper with the most common options.

Once this is in place, the 'test' service can be controled through systemctl
