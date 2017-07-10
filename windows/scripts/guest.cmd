if (Test-Path E:\cert\vbox-sha1.cer) {
  certutil -addstore -f "TrustedPublisher" E:\cert\vbox-sha1.cer
} else {
  certutil -addstore -f "TrustedPublisher" E:\cert\oracle-vbox.cer
}

E:\VBoxWindowsAdditions.exe /S

netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
