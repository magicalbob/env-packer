env-packer
==========

Build an environment from (nearly) nothing.

Things
======

Packer Templates:
	To build images of boxes:
		Linux
		Windows

Configuration Manager:
	To provision the images in the packer build & run
	continuously to keep the instances as they should be.
		Manifests listing top level of each box
		Modules to configure specific software (included by manifest)
		Hieradata
			Including list of box names, their class, their
			IP address etc by environment type:
				Dev
				CI / Lab
				QA
				Production

Vagrantfile:
	To stand up the environment locally (for devs etc).
	Using Virtualbox.
	The Vagrantfile will use the box list in the Hieradata to determine
	which boxes to stand up.

Terraform Configuration:
	To stand up the environment in cloud provider:
		VMware
		AWS
		Azure
	As per the Vagrantfile, the Terraform Configuration should use the
	Hieradata to determine boxes to stand up.

