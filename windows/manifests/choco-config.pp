node default {

  class { 'chocolatey':
    choco_install_timeout_seconds => 3600
  }
  exec { 'cmd.exe /c c:\ProgramData\chocolatey\bin\choco.exe config set commandExecutionTimeoutSeconds 3600':
    path => $::path
  }

}
