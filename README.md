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
	Use mustache templating to handle different configs like template disk sizes.

Configuration Manager:
	To provision the images in the packer build & run
	continuously to keep the instances as they should be.
	Using puppet.
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

Building Images
===============

To build linux image: cd linux; to build windows image: cd windows; then run make-packer.sh. The make-packer.sh takes a number of environment variables as inputs.

Mac OS X only has version 3 of bash. Substitution of lower case variables only became available in bash version 4::

	brew install bash
	sudo mv /bin/bash /bin/bash.save
	sudo mv /bin/sh   /bin/sh.save
	sudo ln -s /usr/local/Cellar/bash/4.3.46/bin/bash /bin/bash
	sudo ln -s /bin/bash /bin/sh
