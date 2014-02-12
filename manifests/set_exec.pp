# systemd::set_exec
# =====================
# $label: should usually stay the default
# $path: This is the path to the file you're setting up
#
# All other options should be directly from the systemd.unit documentation
#  unit_ is prepended to get around reserved params like 'before'
define systemd::set_exec(
  ## Custom to this module
  $path  = undef,
  $label = undef,

  ## Service specific stuff
  $service_type                     = undef,
  $service_remainafterexit          = undef,
  $service_guessmainpid             = undef,
  $service_pidfile                  = undef,
  $service_busname                  = undef,
  $service_execstart                = undef,
  $service_execstartpre             = undef,
  $service_execstartpost            = undef,
  $service_execreload               = undef,
  $service_execstop                 = undef,
  $service_execstoppre              = undef,
  $service_execstoppost             = undef,
  $service_restartsec               = undef,
  $service_timeoutstartsec          = undef,
  $service_timeoutstopsec           = undef,
  $service_timeoutsec               = undef,
  $service_watchdogsec              = undef,
  $service_restart                  = undef,
  $service_successexitstatus        = undef,
  $service_restartpreventexitstatus = undef,
  $service_permissionsstartonly     = undef,
  $service_rootdirectorystartonly   = undef,
  $service_nonblocking              = undef,
  $service_notifyaccess             = undef,
  $service_sockets                  = undef,
  $service_startlimitinterval       = undef,
  $service_startlimitburst          = undef,
  $service_startlimitaction         = undef,


  ## This junk can be applied to any of the exec stuff
  $exec_workingdirectory         = undef,
  $exec_rootdirectory            = undef,
  $exec_user                     = undef,
  $exec_group                    = undef,
  $exec_supplementarygroups      = undef,
  $exec_nice                     = undef,
  $exec_oomscoreadjust           = undef,
  $exec_ioschedulingclass        = undef,
  $exec_ioschedulingpriority     = undef,
  $exec_cpuschedulingpolicy      = undef,
  $exec_cpuschedulingpriority    = undef,
  $exec_cpuschedulingresetonfork = undef,
  $exec_cpuaffinity              = undef,
  $exec_umask                    = undef,
  $exec_environment              = undef,
  $exec_environmentfile          = undef,
  $exec_standardinput            = undef,
  $exec_standardoutput           = undef,
  $exec_standarderror            = undef,
  $exec_ttypath                  = undef,
  $exec_ttyreset                 = undef,
  $exec_ttyvhangup               = undef,
  $exec_ttyvtdisallocate         = undef,
  $exec_syslogidentifier         = undef,
  $exec_syslogfacility           = undef,
  $exec_sysloglevel              = undef,
  $exec_sysloglevelprefix        = undef,
  $exec_timerslacknsec           = undef,
  $exec_limitcpu                 = undef,
  $exec_limitfsize               = undef,
  $exec_limitdata                = undef,
  $exec_limitstack               = undef,
  $exec_limitcore                = undef,
  $exec_limitrss                 = undef,
  $exec_limitnofile              = undef,
  $exec_limitas                  = undef,
  $exec_limitnproc               = undef,
  $exec_limitmemlock             = undef,
  $exec_limitlocks               = undef,
  $exec_limitsigpending          = undef,
  $exec_limitmsgqueue            = undef,
  $exec_limitnice                = undef,
  $exec_limitrtprio              = undef,
  $exec_limitrttime              = undef,
  $exec_pamname                  = undef,
  $exec_tcpwrapname              = undef,
  $exec_capabilityboundingset    = undef,
  $exec_securebits               = undef,
  $exec_capabilities             = undef,
  $exec_readwritedirectories     = undef,
  $exec_readonlydirectories      = undef,
  $exec_inaccessibledirectories  = undef,
  $exec_privatetmp               = undef,
  $exec_privatenetwork           = undef,
  $exec_mountflags               = undef,
  $exec_utmpidentifier           = undef,
  $exec_ignoresigpipe            = undef,
  $exec_nonewprivileges          = undef,
  $exec_systemcallfilter         = undef,
){

  unless $label in ['Service', 'Socket', 'Mount', 'Swap'] {
    fail('Invalid label for exec type')
  }

  if $service_type {
    ## Do some validation
    $valid_service_types = ['simple', 'forking', 'oneshot', 'dbus', 'notify',
    'idle']
    unless $service_type in $valid_service_types {
      fail('Unknown type, see docs for usage')
    }
  }

  if $service_restart {
    $valid_service_restarts = ['no', 'on-success', 'on-failure', 'on-watchdog',
    'on-abort', 'always', absent]
    unless $service_restart in $valid_service_restarts {
      fail('Unknown restart, see docs for usage')
    }
  }

  systemd::set_value{"${path}-unit-cpuaffinity":
    path    => $path,
    section => $label,
    setting => 'CPUAffinity',
    value   => $exec_cpuaffinity
  }

  systemd::set_value{"${path}-unit-cpuschedulingpolicy":
    path    => $path,
    section => $label,
    setting => 'CPUSchedulingPolicy',
    value   => $exec_cpuschedulingpolicy
  }

  systemd::set_value{"${path}-unit-cpuschedulingpriority":
    path    => $path,
    section => $label,
    setting => 'CPUSchedulingPriority',
    value   => $exec_cpuschedulingpriority
  }

  systemd::set_value{"${path}-unit-cpuschedulingresetonfork":
    path    => $path,
    section => $label,
    setting => 'CPUSchedulingResetOnFork',
    value   => $exec_cpuschedulingresetonfork
  }

  systemd::set_value{"${path}-unit-capabilities":
    path    => $path,
    section => $label,
    setting => 'Capabilities',
    value   => $exec_capabilities
  }

  systemd::set_value{"${path}-unit-capabilityboundingset":
    path    => $path,
    section => $label,
    setting => 'CapabilityBoundingSet',
    value   => $exec_capabilityboundingset
  }

  systemd::set_value{"${path}-unit-environment":
    path    => $path,
    section => $label,
    setting => 'Environment',
    value   => $exec_environment
  }

  systemd::set_value{"${path}-unit-environmentfile":
    path    => $path,
    section => $label,
    setting => 'EnvironmentFile',
    value   => $exec_environmentfile
  }

  systemd::set_value{"${path}-unit-group":
    path    => $path,
    section => $label,
    setting => 'Group',
    value   => $exec_group
  }

  systemd::set_value{"${path}-unit-ioschedulingclass":
    path    => $path,
    section => $label,
    setting => 'IOSchedulingClass',
    value   => $exec_ioschedulingclass
  }

  systemd::set_value{"${path}-unit-ioschedulingpriority":
    path    => $path,
    section => $label,
    setting => 'IOSchedulingPriority',
    value   => $exec_ioschedulingpriority
  }

  systemd::set_value{"${path}-unit-ignoresigpipe":
    path    => $path,
    section => $label,
    setting => 'IgnoreSIGPIPE',
    value   => $exec_ignoresigpipe
  }

  systemd::set_value{"${path}-unit-inaccessibledirectories":
    path    => $path,
    section => $label,
    setting => 'InaccessibleDirectories',
    value   => $exec_inaccessibledirectories
  }

  systemd::set_value{"${path}-unit-limitas":
    path    => $path,
    section => $label,
    setting => 'LimitAS',
    value   => $exec_limitas
  }

  systemd::set_value{"${path}-unit-limitcore":
    path    => $path,
    section => $label,
    setting => 'LimitCORE',
    value   => $exec_limitcore
  }

  systemd::set_value{"${path}-unit-limitcpu":
    path    => $path,
    section => $label,
    setting => 'LimitCPU',
    value   => $exec_limitcpu
  }

  systemd::set_value{"${path}-unit-limitdata":
    path    => $path,
    section => $label,
    setting => 'LimitDATA',
    value   => $exec_limitdata
  }

  systemd::set_value{"${path}-unit-limitfsize":
    path    => $path,
    section => $label,
    setting => 'LimitFSIZE',
    value   => $exec_limitfsize
  }

  systemd::set_value{"${path}-unit-limitlocks":
    path    => $path,
    section => $label,
    setting => 'LimitLOCKS',
    value   => $exec_limitlocks
  }

  systemd::set_value{"${path}-unit-limitmemlock,":
    path    => $path,
    section => $label,
    setting => 'LimitMEMLOCK,',
    value   => $exec_limitmemlock,
  }

  systemd::set_value{"${path}-unit-limitmsgqueue":
    path    => $path,
    section => $label,
    setting => 'LimitMSGQUEUE',
    value   => $exec_limitmsgqueue
  }

  systemd::set_value{"${path}-unit-limitnice":
    path    => $path,
    section => $label,
    setting => 'LimitNICE',
    value   => $exec_limitnice
  }

  systemd::set_value{"${path}-unit-limitnofile":
    path    => $path,
    section => $label,
    setting => 'LimitNOFILE',
    value   => $exec_limitnofile
  }

  systemd::set_value{"${path}-unit-limitnproc":
    path    => $path,
    section => $label,
    setting => 'LimitNPROC',
    value   => $exec_limitnproc
  }

  systemd::set_value{"${path}-unit-limitrss":
    path    => $path,
    section => $label,
    setting => 'LimitRSS',
    value   => $exec_limitrss
  }

  systemd::set_value{"${path}-unit-limitrtprio":
    path    => $path,
    section => $label,
    setting => 'LimitRTPRIO',
    value   => $exec_limitrtprio
  }

  systemd::set_value{"${path}-unit-limitrttime":
    path    => $path,
    section => $label,
    setting => 'LimitRTTIME',
    value   => $exec_limitrttime
  }

  systemd::set_value{"${path}-unit-limitsigpending":
    path    => $path,
    section => $label,
    setting => 'LimitSIGPENDING',
    value   => $exec_limitsigpending
  }

  systemd::set_value{"${path}-unit-limitstack":
    path    => $path,
    section => $label,
    setting => 'LimitSTACK',
    value   => $exec_limitstack
  }

  systemd::set_value{"${path}-unit-mountflags":
    path    => $path,
    section => $label,
    setting => 'MountFlags',
    value   => $exec_mountflags
  }

  systemd::set_value{"${path}-unit-nice":
    path    => $path,
    section => $label,
    setting => 'Nice',
    value   => $exec_nice
  }

  systemd::set_value{"${path}-unit-nonewprivileges":
    path    => $path,
    section => $label,
    setting => 'NoNewPrivileges',
    value   => $exec_nonewprivileges
  }

  systemd::set_value{"${path}-unit-oomscoreadjust":
    path    => $path,
    section => $label,
    setting => 'OOMScoreAdjust',
    value   => $exec_oomscoreadjust
  }

  systemd::set_value{"${path}-unit-pamname":
    path    => $path,
    section => $label,
    setting => 'PAMName',
    value   => $exec_pamname
  }

  systemd::set_value{"${path}-unit-privatenetwork":
    path    => $path,
    section => $label,
    setting => 'PrivateNetwork',
    value   => $exec_privatenetwork
  }

  systemd::set_value{"${path}-unit-privatetmp":
    path    => $path,
    section => $label,
    setting => 'PrivateTmp',
    value   => $exec_privatetmp
  }

  systemd::set_value{"${path}-unit-readonlydirectories":
    path    => $path,
    section => $label,
    setting => 'ReadOnlyDirectories',
    value   => $exec_readonlydirectories
  }

  systemd::set_value{"${path}-unit-readwritedirectories":
    path    => $path,
    section => $label,
    setting => 'ReadWriteDirectories',
    value   => $exec_readwritedirectories
  }

  systemd::set_value{"${path}-unit-rootdirectory":
    path    => $path,
    section => $label,
    setting => 'RootDirectory',
    value   => $exec_rootdirectory
  }

  systemd::set_value{"${path}-unit-securebits":
    path    => $path,
    section => $label,
    setting => 'SecureBits',
    value   => $exec_securebits
  }

  systemd::set_value{"${path}-unit-standarderror":
    path    => $path,
    section => $label,
    setting => 'StandardError',
    value   => $exec_standarderror
  }

  systemd::set_value{"${path}-unit-standardinput":
    path    => $path,
    section => $label,
    setting => 'StandardInput',
    value   => $exec_standardinput
  }

  systemd::set_value{"${path}-unit-standardoutput":
    path    => $path,
    section => $label,
    setting => 'StandardOutput',
    value   => $exec_standardoutput
  }

  systemd::set_value{"${path}-unit-supplementarygroups":
    path    => $path,
    section => $label,
    setting => 'SupplementaryGroups',
    value   => $exec_supplementarygroups
  }

  systemd::set_value{"${path}-unit-syslogfacility":
    path    => $path,
    section => $label,
    setting => 'SyslogFacility',
    value   => $exec_syslogfacility
  }

  systemd::set_value{"${path}-unit-syslogidentifier":
    path    => $path,
    section => $label,
    setting => 'SyslogIdentifier',
    value   => $exec_syslogidentifier
  }

  systemd::set_value{"${path}-unit-sysloglevel":
    path    => $path,
    section => $label,
    setting => 'SyslogLevel',
    value   => $exec_sysloglevel
  }

  systemd::set_value{"${path}-unit-sysloglevelprefix":
    path    => $path,
    section => $label,
    setting => 'SyslogLevelPrefix',
    value   => $exec_sysloglevelprefix
  }

  systemd::set_value{"${path}-unit-systemcallfilter":
    path    => $path,
    section => $label,
    setting => 'SystemCallFilter',
    value   => $exec_systemcallfilter
  }

  systemd::set_value{"${path}-unit-tcpwrapname":
    path    => $path,
    section => $label,
    setting => 'TCPWrapName',
    value   => $exec_tcpwrapname
  }

  systemd::set_value{"${path}-unit-ttypath":
    path    => $path,
    section => $label,
    setting => 'TTYPath',
    value   => $exec_ttypath
  }

  systemd::set_value{"${path}-unit-ttyreset":
    path    => $path,
    section => $label,
    setting => 'TTYReset',
    value   => $exec_ttyreset
  }

  systemd::set_value{"${path}-unit-ttyvhangup":
    path    => $path,
    section => $label,
    setting => 'TTYVHangup',
    value   => $exec_ttyvhangup
  }

  systemd::set_value{"${path}-unit-ttyvtdisallocate":
    path    => $path,
    section => $label,
    setting => 'TTYVTDisallocate',
    value   => $exec_ttyvtdisallocate
  }

  systemd::set_value{"${path}-unit-timerslacknsec":
    path    => $path,
    section => $label,
    setting => 'TimerSlackNSec',
    value   => $exec_timerslacknsec
  }

  systemd::set_value{"${path}-unit-umask":
    path    => $path,
    section => $label,
    setting => 'UMask',
    value   => $exec_umask
  }

  systemd::set_value{"${path}-unit-user":
    path    => $path,
    section => $label,
    setting => 'User',
    value   => $exec_user
  }

  systemd::set_value{"${path}-unit-utmpidentifier":
    path    => $path,
    section => $label,
    setting => 'UtmpIdentifier',
    value   => $exec_utmpidentifier
  }

  systemd::set_value{"${path}-unit-workingdirectory":
    path    => $path,
    section => $label,
    setting => 'WorkingDirectory',
    value   => $exec_workingdirectory
  }
}
