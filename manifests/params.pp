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
# [*nginx*]
#   Use nginx web server package, default apache 
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
    # $php_version = '5.4'
    # $zs_version  = '6.1.0'
    # $nginx		 = false
    # $common_ext  = false
    # $extra_ext   = false
    # $unix_ext    = false


	# PHP version to be used
	$php_version = "5.4"
	# Zend Server version to be used
	$zs_version = "6.1.0"
	# Set up nginx boolean
	$nginx = false
	
	# zend server install path
	$install_path = "/usr/local/zend"
	# default Vhost path
	$default_vhost = "${install_path}/etc/sites.d/zend-default-vhost-80.conf"
	# admin password
	$admin_password = "vagrant"
	# developer password
	$devPassword = ''
	# Zend Server Order Number
	$orderNumber = ''
	# Zend Server Licence Key
	$licenseKey = ''
	# Accept EULA must be true
	$acceptEula = "TRUE"
	# default App URL defailt: empty
	$appUrl = ''
	# set configuration envoirment to production
	$production = "TRUE"


}
