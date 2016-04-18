# Overview

This repo contains [Vagrant](https://www.vagrantup.com/) scripts for easily spinning up and automatically provisioning a CentOS 6.7 development server virtual machine with the the following software:

1. Apache 2.2.15
2. MySQL 5.1.73
3. PHP 5.5.34

  > Modules: php, [php-cli](http://php.net/manual/en/features.commandline.php), php-common, php-devel, php-fpm, php-gd, php-imap, php-ldap, php-mbstring, [php-opcache](http://php.net/manual/en/book.opcache.php), [php-pdo](http://php.net/manual/en/book.pdo.php), [php-pear](https://pear.php.net/), php-pecl-apcu, [php-xml](http://php.net/manual/en/book.xml.php), [php-xmlrpc](http://php.net/manual/en/book.xmlrpc.php)

  > PEAR packages: PHP_CodeSniffer, [Auth_SASL](https://pear.php.net/package/Auth_SASL), DB, Date, File, HTTP_Request, Log, MDB2, MDB2_Driver_mysql, Mail, Mail_Mime, Net_SMTP, Net_Sieve, Net_Socket, Net_URL

# Prerequisites

1. You must have virtualization software installed on your machine. Currently only [Virtual Box](https://www.vagrantup.com/docs/virtualbox/) providers have been coded and tested but [VMware](https://www.vagrantup.com/docs/vmware/) Workstation and Fusion, [Parallels](http://parallels.github.io/vagrant-parallels/docs/), and [Hyper-V](https://www.vagrantup.com/docs/vmware/) providers are also possible (pull requests appreciated if you update & test).
1. You must have [Vagrant](https://www.vagrantup.com/downloads.html) installed.
1. You might need [Cygwin](https://www.cygwin.com/) or [git for Windows](https://git-for-windows.github.io/) installed - necessary as Vagrant uses bash for some of its work.

> NOTE: Typically, a collection of installer images are unpacked and mounted in a common location such as on a shared network folder or an attached external hard drive (USB, Thunderbolt, etc.).


# Notes

### Running

To run this script do the following:

  1. Clone this repo somewhere on your disk (`~/vagrant` *or* `%HOMEPATH%\vagrant`)
  1. Open a terminal or command prompt and navigate to the cloned repo (`cd ~/vagrant/cent67php` *or* `cd %HOMEPATH%\vagrant\cent67php`)
  1. Run the following command:

  ``` shell
  vagrant up
  ```

  Optionally you may specify your virtualization provider if not using the defult (virtualbox):

  ``` shell
  vagrant up --provider vmware|fusion|hyperv
  ```

  The first time you run `vagrant up` the provisioning phase will occur and will likely take 5-10 minutes.
  Subsequently `vagrant up` will simply start your already-provisioned machine.

  1. Run `vagrant ssh` to connect to your newly spun up running instance.
  1. Run `vagrant halt` to issue an orderly shutdown.
  1. Run `vagrant suspend` to save the machine's state to disk (e.g. hibernate) and power off (run `vagrant up` again to restart/restore state).
  1. Run `vagrant destroy` to permanently destroy the image.
  1. Run `vagrant provision` to manually re-run the provisioning phase. This will likely re-install software and re-apply configurations depending on what exactly the provision steps are written to do. NOTE: Since Vagrant must be running for the provision command to work, you may also combine into a single command `vagrant up --provision`.


### Port Forwarding

| host | guest | notes  |
| ---- | ----- | ------ |
| 8000 |  80   | Apache, localhost:8000/phpinfo.php or localhost:8000/phpMyAdmin |
| 8306 | 3306  | MySQL, use vagrant/vagrant for login |

>  1. [Apache 2 Test Page](http://localhost:8000/)
>  1. [PHP Info Page](http://localhost:8000/phpinfo.php)
>  1. [PHP MyAdmin Page](http://localhost:8000/phpMyAdmin/index.php)


### Known Issues

None.
