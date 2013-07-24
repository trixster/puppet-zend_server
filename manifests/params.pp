# = Class: zend_server::params
#
# This class handles the default parameters.
#
#
# == Parameters
#
# Module specific parameters
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

class zend_server::params {
    $php_version = '5.4'
    $zs_version  = '6.1.0'
    $web_server  = 'httpd'
    $common_ext  = true
    $extra_ext   = false
    $unix_ext    = true
}
