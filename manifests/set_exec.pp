# systemd::set_exec
# =====================
# $section_label: should usually stay the default
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



}
