Zend Server Puppet Module
=========================

A puppet module for [Zend Server](http://www.zend.com/en/products/server/)

Find it on [PuppetForge](https://forge.puppetlabs.com/mwillbanks/zend_server)

Introduction
------------

The Zend Server module by default *does not provide any repositories* so that
setup must be done in advance.  You should follow the documentation on setting
up your repositories.

Secondly, extensions are expected to be made into packages.  This is a larger
difference as nothing is compiled from pecl but rather a package is required
instead.

Getting Started
---------------

* Install Zend Server with default settings

        class { 'zend_server': }

* Install Zend Server considering all parameters

        class { 'zend_server':
            php_version => '5.4',
            zs_version  => '6.1.0',
            web_server  => 'httpd',
            common_ext  => true,
            extra_ext   => false,
            unix_ext    => true,
        }


### Parameters ###

* php_version
  The PHP Major.Minor version
* zs_version
  The Zend Server version
* web_server
  The web server package from your package management system
* common_ext
  Installs the common extension package
* extra_ext
  Installs the extra extension package
* unix_ext
  Installs the unix extension package


Installing Extensions
---------------------

As noted above; extensions must be in the form of packages.  So if you do need
specific PECL extensions you must build them into a package and put them into a
repository somewhere.

There is only the default extension installation which takes the name of the
extension and creates a configuration file in conf.d with the extension name and
provides the enabling of the extension.

* Default Extension Installation

        zend_server::extension { "bzip":
            extension => 'bzip',
        }

INI Configuration
-----------------

The ini configuration class allows you to generate an ini file in the conf.d
directory.  This will provide the ability to customize your PHP installation
without having to touch the main php.ini file for example the date.timezone
configuration.

* Example of creating conf.d/date.ini

        zend_server::ini { "date":
            options => { 'date.timezone' => 'UTC', },
            target  => 'date',
        }

