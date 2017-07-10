powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi', 'C:\Windows\Temp\puppet.msi')"

msiexec /qn /i C:\Windows\Temp\puppet.msi /log C:\Windows\Temp\puppet.log

