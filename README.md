# Overview

This repo contains [Vagrant](https://www.vagrantup.com/) scripts for easily spinning up and automatically provisioning one or more virtual machines and, in the future, [Docker](https://www.docker.com/) images. The heart of these scripts is the [Vagrantfile](https://www.vagrantup.com/docs/vagrantfile/) that contains instructions for the hypervisor configuration for the new instance as well as provisioning steps that are applied automatically when creating a new instance from an image.

# Prerequisites

1. You must have virtualization software installed on your machine. Currently only [Virtual Box](https://www.vagrantup.com/docs/virtualbox/) providers have been coded and tested but [VMware](https://www.vagrantup.com/docs/vmware/) Workstation and Fusion, [Parallels](http://parallels.github.io/vagrant-parallels/docs/), and [Hyper-V](https://www.vagrantup.com/docs/vmware/) providers are also possible (pull requests appreciated if you update & test).
1. You must have [Vagrant](https://www.vagrantup.com/downloads.html) installed.
1. You might need [Cygwin](https://www.cygwin.com/) or [git for Windows](https://git-for-windows.github.io/) installed - necessary as Vagrant uses bash for some of its work.

> NOTE: Typically, a collection of installer images are unpacked and mounted in a common location such as on a shared network folder or an attached external hard drive (USB, Thunderbolt, etc.).


# Quick Steps

1. Clone this repo to a local folder on your computer.
1. Open a terminal or command prompt and navigate to the subfolder of the machine you wish to create.
1. Run the following command:

  ``` shell
  vagrant up
  ```

  Optionally you may specify your virtualization provider if not using the default (virtualbox):

  ``` shell
  vagrant up --provider vmware|fusion|hyperv
  ```

  The first time you run `vagrant up` the provisioning phase will occur and will likely take a few minutes unless the guest OS is Windows then go for a walk and buy a cup of coffee - it could be an hour or two!
  Subsequently `vagrant up` will simply start your already-provisioned machine.

1. Connect to your newly spun up running instance.
    * Run `vagrant ssh` to connect to a Linux guest OS.
    * Run `vagrant rdp` to connect to a Windows guest OS. *This also works on Mac if you have [Microsoft Remote Desktop](https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12) installed on OS X.*
1. Run `vagrant halt` to issue an orderly shutdown.
1. Run `vagrant suspend` to save the machine's state to disk (e.g. hibernate) and power off (run `vagrant up` again to restart/restore state).
1. Run `vagrant destroy` to permanently destroy the image.
1. Run `vagrant provision` to manually re-run the provisioning phase. This will likely re-install software and re-apply configurations depending on what exactly the provision steps are written to do. NOTE: Since Vagrant must be running for the provision command to work, you may also combine into a single command `vagrant up --provision`.


# List of Vagrant Provisioning Scripts

| script | notes |
| ----   | ----- |
| [cent67php](cent67php/README.md) | CentOS 6.7 PHP development server |
| [win81dev](win81dev/README.md)   | Windows 8.1 Ent. VS 2015 & SQL 2014 |
| [win81sql](win81sql/README.md)   | Windows 8.1 Ent. SQL 2014 Developer Edition |
| [win81vs12](win81vs12/README.md) | Windows 8.1 Ent. VS 2012 |
| [win10dev](win10dev/README.md)   | Windows 10 Ent. (1511) VS 2015 & SQL 2014 |


# Notes

The philosophy here is to use Vagrant to quickly bootstrap a machine then do all of the specific provisioning and installation steps using the [ansible_local](https://www.vagrantup.com/docs/provisioning/ansible_local.html) or [puppet apply](https://docs.puppetlabs.com/puppet/latest/reference/services_apply.html) provisioner within the guest machine for the following reasons:

1. Vagrant provisioning often ends up being shell commands which in turn end up being brittle, guest OS specific, and less portable. Providers such as [ansible_local](https://www.vagrantup.com/docs/provisioning/ansible_local.html) or [puppet apply](https://docs.puppetlabs.com/puppet/latest/reference/services_apply.html) abstract these details away.
1. Vagrant provisioning executes from the host machine which puts a burden of more prerequisites on the host machine and consumer of these scripts - **you**
1. [ansible_local](https://www.vagrantup.com/docs/provisioning/ansible_local.html) and [puppet apply](https://docs.puppetlabs.com/puppet/latest/reference/services_apply.html) runs within the guest machine which implies a known execution environment (what is the host machine running - Linux/Windows/OS X??), reducing the pre-reqs and setup on the host machine.
1. Wherever possible use already built Ansible roles or Puppet modules (or build new ones specific to the need) so that we can re-use them. Resorting to shell commands because you like that or already have a snippet that does what you want is not the preferred approach. Your shell skills, preferences, quirks, beliefs or dogma aren't interesting to everyone or me at the moment - rather, I care about quickly adding value using lean principles. That means standard roles/modules and platform neutral coding wherever possible - speed and consistency over custom coding and hand-crafted steps.
1. Use sensible variables and environment settings that:
   1. Isolate hard-coded values so that they can easily be replaced
   1. Are ideally surfaced in the `Vagrantfile` through `vagrant.yml` so that consumers only have one place to go to fix up settings to suit their needs as well as easily override them via command line arguments.
1. Base boxes ideally should come from a [packer-](https://www.packer.io/) based script rather than pre-built images from an external Internet site.
   1. You have no control over what external images contain or if they have been tampered with.
   1. Scripted base boxes can be standard, hardened images built by you on your network from known operating system ISO images.

# Known Problems

1. Vagrant and Virtual Box on Windows does not completely rename the virtual machine to the name specified in the `Vagrantfile`.
   1. The virtual machine will fail to start and you'll be left with multiple lines of red error messages in the console window.
   1. Follow the one-time instructions in the [Windows](Windows.md) notes to manually complete the rename process and resume.
1. Windows networking & firewall sometimes will get in the way. When the virtual machine first boots it might detect a "new/different" network that it has not seen before. When this happens the default behavior is to assume the network is a "Public" one and to bring up the firewall security to maximum settings. This has the effect of causing WinRM (Windows Remote Management) to be blocked and since vagrant uses WinRM to communicate with the virtual machine it will "hang" until it eventually times out.
    1. Edit `vagrant.yml` and specfiy `v_console: true` then kill and restart the vagrant process.
    1. Log into the virtual machine when the console is available and change the `Network Location` from "Public" to either "Work" or "Home" and save it [How-To](http://www.eightforums.com/tutorials/9837-network-location-set-private-public-windows-8-a.html). You should begin seeing network activity on the virtual machine's indicators as vagrant is now able to communicate.
    1. After provisioning you can switch back to `v_console: false` and use `vagrant rdp` to get a full remote session to work in.