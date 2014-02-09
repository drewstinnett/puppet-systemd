# Systemd #

Set up and configure systemd files on a system.

**This is not for replacing the built in puppet service type, however it can
be used to generate $name.service files on the filesystem.**

## Quickstart ##

Service File Configuration

    systemd::service_file{'splunk':
      description  => 'Splunk Log Management Service',
      type         => 'forking',
      pidfile      => "${install_dir}/var/run/splunk/splunkd.pid",
      execstart    => "${splunk_bin} start ${license_nag}",
      execstartpre => "/usr/bin/chown -R ${user}:${group} ${install_dir}",
      execstop     => "${splunk_bin} stop",
      execreload   => "${splunk_bin} restart ${license_nag}",
      timeout      => '350'
    }

Once this is in place, the 'splunk' service can be controled through systemctl
