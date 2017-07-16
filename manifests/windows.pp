node default {

  package { 'javaruntime':
    ensure   => '7.0.75',
    provider => chocolatey
  }

  package { 'visualstudio2015community':
    ensure   => installed,
    provider => chocolatey
  }

  package { '7zip':
    ensure   => installed,
    provider => chocolatey
  }

  package { 'nuget.commandline':
    ensure   => installed,
    provider => chocolatey
  }

  package { 'setacl':
    ensure   => installed,
    provider => chocolatey
  }

  archive { 'unzip dotnet45':
    source        => 'https://dev.ellisbs.co.uk/files/dotnetfx45_full_x86_x64.zip',
    path            => 'C:/windows/temp/dotnetfx45_full_x86_x64.zip',
    checksum      => '0e150a575c7b0e8e7c443337f900ae71',
    checksum_type => 'md5',
    extract       => true,
    extract_path  => 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\SDK\Bootstrapper\Packages',
    creates       => 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\SDK\Bootstrapper\Packages\DotNetFX45\dotnetfx45_full_x86_x64.exe',
    require       => Package['7zip']
  }

  archive { 'unzip vcredist_x86_2013.zip':
    source        => 'https://dev.ellisbs.co.uk/files/vcredist_x86_2013.zip',
    path            => 'C:/windows/temp/vcredist_x86_2013.zip',
    checksum      => '2b2b1c0929a51503f4d147f5ae2a516b',
    checksum_type => 'md5',
    extract       => true,
    extract_path  => 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\SDK\Bootstrapper\Packages',
    creates       => 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\SDK\Bootstrapper\Packages\vcredist_x86_2013\en',
    require       => Package['7zip']
  }

  archive { 'unzip VSI_bundle':
    source        => 'https://dev.ellisbs.co.uk/files/VSI_bundle.zip',
    path            => 'C:/windows/temp/VSI_bundle.zip',
    checksum      => '1edb84ced9825966b022c5221fffc5d5',
    checksum_type => 'md5',
    extract       => true,
    extract_path  => 'C:\Windows\Temp',
    creates       => 'C:\Windows\Temp\VSI_bundle\VSI_bundle.exe',
    require       => Package['7zip']
  }

  exec { 'visualstudio VSI_bundle':
    command => 'cmd.exe /c c:\Windows\Temp\VSI_bundle\VSI_bundle.exe /Q',
    path    => $::path,
    require => Package['visualstudio2015community']
  }

  exec { 'visualstudio InstallVSTemplates':
    command => 'cmd.exe /c "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /InstallVSTemplates',
    path    => $::path,
    require => Package['visualstudio2015community']
  }

  exec { 'visualstudio Setup':
    command => 'cmd.exe /c "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /Setup',
    path    => $::path,
    require => Exec['visualstudio VSI_bundle','visualstudio InstallVSTemplates']
  }

  exec { 'visualstudio registry all':
    command => 'cmd.exe /c reg add HKU\.DEFAULT\Software\Microsoft\VisualStudio\14.0_Config\MSBuild /v EnableOutOfProcBuild /t REG_DWORD /d 0',
    path    => $::path,
    require => Exec['visualstudio Setup']
  }

  exec { 'visualstudio registry current':
    command => 'cmd.exe /c reg add HKCU\Software\Microsoft\VisualStudio\14.0_Config\MSBuild /v EnableOutOfProcBuild /t REG_DWORD /d 0',
    path    => $::path,
    require => Exec['visualstudio Setup']
  }

  package { 'windows-sdk-8.0':
    ensure   => installed,
    provider => chocolatey
  }

  exec { 'puppet run once':
    command => 'cmd.exe /c reg add HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce /v RunPuppet /t REG_SZ /d "c:\progra~1\puppet~1\puppet\bin\puppet.bat apply c:\vagrant\manifests\windows.pp"',
    path    => $::path,
    require => Exec['visualstudio Setup']
  }
}
