export ISO_URL=../iso_installation/WinServer2016.iso 
export ISO_MD5=70721288bbcdfe3239d8f8c0fae55f1f
export WINRM_USERNAME=vagrant
export WINRM_PASSWORD=vagrant
packer build windows.json
