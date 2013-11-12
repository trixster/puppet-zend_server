# = Class: zend_server::extension
#
# This class handles ensuring extension packages and ini files are loaded
#
#
# == Parameters
#
# Module specific parameters
# [*extension*]
#   Name of the extension
#
# Default class parameters
# [*php_version*]
#   The PHP version of the extension
#
# [*zs_version*]
#   The Zend Server version
#
#
define zend_server::extension (
    $extension,
    $php_version = $zend_server::php_version,
    $zs_version  = $zend_server::zs_version
) {
    include zend_server

    package { "php-${php_version}-${extension}-zend-server":
        ensure  => 'present',
        name    => "php-${php_version}-${extension}-zend-server",
        notify  => Service['zend-server'],
        require => Package["zend-server-php-${php_version}"]
    }

    zend_server::ini { $extension:
        options => { extension => "${extension}.so" },
        target  => $extension,
    }
}
