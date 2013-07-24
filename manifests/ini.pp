# = Class: zend_server:ini
#
# This class handles defining conf.d files with a hash of ini options
#
#
# == Parameters
#
# Module specific paramaters
# [*options*]
#   Hash of ini options in key => value formats
#
# [*target*]
#   The name of the ini file you would like to have
#
# Default class parameters
# [*php_version*]
#   The PHP version of the extension
#
# [*zs_version*]
#   The Zend Server version
#
#
define zend_server::ini (
    $options,
    $target,
    $php_version = $zend_server::php_version,
    $zs_version  = $zend_server::zs_version
) {
    include zend_server

    file { "/usr/local/zend/etc/conf.d/${target}.ini":
        ensure  => 'present',
        content => template('zend_server/ini.erb'),
        notify  => Service['zend-server'],
        require => Package["zend-server-php-${php_version}-${zs_version}"]
    }
}
