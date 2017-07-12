node default {
  exec { 'make sure dir there': 
    command => 'cmd.exe /c mkdir "c:/vagrant/files"',
    path    => $::path
  }

  exec { 'get VSI_bundle':
    command => 'cmd.exe /c powershell -Command "Start-BitsTransfer -Source https://dev.ellisbs.co.uk/files/VSI_bundle.exe -Destination c:/vagrant/files/VSI_bundle.exe"',
    path    => $::path,
    require => Exec['make sure dir there']
  }

  exec { 'get vcredist':
    command => 'cmd.exe /c powershell -Command "Start-BitsTransfer -Source https://dev.ellisbs.co.uk/files/vcredist_x86_2013.zip -Destination c:/vagrant/files/vcredist_x86_2013.zip"',
    path    => $::path,
    require => Exec['make sure dir there']
  }

  exec { 'get dotnet':
    command => 'cmd.exe /c powershell -Command "Start-BitsTransfer -Source https://dev.ellisbs.co.uk/files/dotnetfx45_full_x86_x64.exe -Destination c:/vagrant/files/dotnetfx45_full_x86_x64.exe"',
    path    => $::path,
    require => Exec['make sure dir there']
  }
}






