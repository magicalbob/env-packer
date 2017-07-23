env-packer
==========

Build an environment from (nearly) nothing.

Needs
=====

To be able to reproducibly create defined versions of a whole system from a simple script with minimal input.

Benefits
========

Allows new devs to get working with the systems without having to first learn how to set up development environments on their own kit.

Allows devs to test software & infrastructure changes on their own kit before sharing them back to the project.

Enables automated testing of software & infrastructure changes.

Provides (& proves) "disaster recovery".

Patching. Deliverables are fully patched boxes. Regular delivery of boxes means regularly patched system.

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

