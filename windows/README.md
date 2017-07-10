Packer Code to Create Windows Vagrant Box
=========================================

Requires Packer, Virtual Box and Vagrant are installed. Also requires an ISO image of a Windows install disk.

Visit https://www.packer.io/downloads.html to get packer. Put it somewhere in your PATH.

Visit https://www.virtualbox.org/wiki/Downloads to get Virtual Box and see instructions on installing.

Visit https://www.vagrantup.com/docs/installation/ to get Vagrant and see instructions on installing.

Visit https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016 to get an evaluation ISO of Windows Server 2016. The windows.json file expects the ISO to be called WinServer2016.iso (in the same directory as windows.json). 

The windows.json file defines the packer build. To make the machine run::

  packer build windows.json

The packer will output a vagrant box file windows2016-virtualbox.box. To install it run command::

  vagrant box add -f windows windows2016-virtualbox.box

To stand up a windows box::

  vagrant init
  vagrant up

Windows will be activated for 180 days from when the packer build was run. So if it's rebuilt regularly, Windows will always be activated.

Finding guest_os_type
---------------------

Simply run this command to get a complete list::

  VBoxManage list ostypes

Jenkins Slave
-------------

Windows Server 2012 (64bit)
To connect to Windows Server 2012, Change Permission for following registry key to Full Control:
- HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Wow6432Node\CLSID\{72C24DD5-D70A-438B-8A42-98424B88AFB8}
- HKEY_CLASSES_ROOT\CLSID\{76A64158-CB41-11D1-8B02-00600806D9B6}
Launch 'regedit' (as Administrator)
Find (Ctrl+F) the following registry key: "{72C24DD5-D70A-438B-8A42-98424B88AFB8}" in HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Wow6432Node\CLSID\
Right click and select 'Permissions'
Change owner to administrators group (Advanced...).
Change permissions for administrators group. Grant Full Control.
Change owner back to TrustedInstaller (user is "NT Service\TrustedInstaller" on local machine)
Repeat the steps 1-6 for HKEY_CLASSES_ROOT\CLSID{76A64158-CB41-11D1-8B02-00600806D9B6}
Restart Remote Registry Service (Administrative Tools / Services)
The user that is used for logging on also needs the permission "Log on as a service":
To open Local Security Policy, click Start, point to Control Panel, point to Administrative Tools, and then double-click Local Security Policy.
In the console tree, double-click Local Policies, and then click User Rights Assignment.
In the details pane, double-click Log on as a service.

https://wiki.jenkins-ci.org/display/JENKINS/Windows+slaves+fail+to+start+via+DCOM#WindowsslavesfailtostartviaDCOM-LocalSecuritySettings
