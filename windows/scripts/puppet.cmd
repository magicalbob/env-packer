puppet apply a:\puppetlabs-windows.pp
puppet apply a:\choco.pp
puppet apply a:\choco-config.pp
copy a:\windows.pp c:\ProgramData\PuppetLabs\code\environments\production\manifests\site.pp
puppet apply c:\ProgramData\PuppetLabs\code\environments\production\manifests\site.pp
