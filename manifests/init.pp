# = Class: zend_server
#
# This class handles ensuring that Zend Server is installed with
# pre-defined requirements
#
#
# == Parameters
#
# Default class parameters
# [*php_version*]
#   The PHP version to use
#
# [*zs_version*]
#   The Zend Server version to use
#
# [*web_server*]
#   The web server package name
#
# [*common_ext*]
#   Use the common extensions
#
# [*extra_ext*]
#   Use the extra extensions
#
# [*unix_ext*]
#   Use the unix extensions
#
#
class zend_server (
    $php_version = $zend_server::params::php_version,
    $zs_version  = $zend_server::params::zs_version,
    $web_server  = $zend_server::params::web_server,
    $common_ext  = $zend_server::params::common_ext,
    $extra_ext   = $zend_server::params::extra_ext,
    $unix_ext    = $zend_server::params::unix_ext
) inherits zend_server::params {

    package { $web_server:
        ensure => 'present',
        name   => $web_server,
    }

    package { "zend-server-php-${php_version}-${zs_version}":
        ensure => 'present',
        name   => "zend-server-php-${php_version}-${zs_version}",
    }

    $common_ensure = $zend_server::common_ext ? {
        true  => 'present',
        false => 'absent',
    }
    package { "php-${php_version}-common-extensions-zend-server":
        ensure  => $common_ensure,
        name    => "php-${php_version}-common-extensions-zend-server",
        require => Package["zend-server-php-${php_version}-${zs_version}"],
    }

    $extra_ensure = $zend_server::extra_ext ? {
        true  => 'present',
        false => 'absent',
    }
    package { "php-${php_version}-extra-extensions-zend-server":
        ensure  => $extra_ensure,
        name    => "php-${php_version}-extra-extensions-zend-server",
        require => Package["zend-server-php-${php_version}-${zs_version}"],
    }

    $unix_ensure = $zend_server::unix_ext ? {
        true  => 'present',
        false => 'absent',
    }
    package { "php-${php_version}-unix-extensions-zend-server":
        ensure  => $unix_ensure,
        name    => "php-${php_version}-unix-extensions-zend-server",
        require => Package["zend-server-php-${php_version}-${zs_version}"],
    }

    file { "/etc/profile.d/zend-server.sh":
        mode   => 755,
        owner  => root,
        group  => root,
        source => "puppet:///modules/zend_server/zend-server.sh",
    }

    service { 'zend-server':
        ensure     => 'running',
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        require    => Package["zend-server-php-${php_version}-${zs_version}"],
    }
}
