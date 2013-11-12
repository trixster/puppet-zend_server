define zend_server::package (
	$zs_version ,
	$php_version,
 	$nginx
 	){

	case $nginx {
		true: {
			$zend_package = "zend-server-nginx-php-${php_version}"
		}
		default: {
			$zend_package = "zend-server-php-${php_version}"
			
		} 
	}

	notify{"Package name: ${zend_package}":}
	
	package { 'zendserver':
		name => $zend_package,
		ensure => 'latest',

	}
	
	

}