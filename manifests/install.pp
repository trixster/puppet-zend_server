
class zend_server::install (
  $version           = '',
  $php_version       = '',
  $nginx             = '',
  $community_edition = '',
  $install_path      = $zend_server::params::install_path,
  $default_vhost     = $zend_server::params::default_vhost,
  ) {
	  
	  include zend_server::params
	  
	  if $version == '' {
	    $version = $zend_server::params::version
	  }
	  
	  if $php_version == '' {
	    $php_version = $zend_server::params::php_version  
	  }
	  
	  if $ngnix == '' {
	    $ngnix = $zend_server::params::nginx
	    
	    }
	  if $community_edition == '' {
	    $community_edition = $zend_server::params::ce
	  
	  }
	  if $install_path == '' {
	    $install_path = $zend_server::params::install_path
	    
	  }
	  if $default_vhost == '' {
	    $default_vhost  = $zend_server::params::default_vhost
	  }
	  
	  notify {"variables":
	    message => "Version: ${version} \n  php_version: $php_version \n nginx: $nginx \n install_path: $install_path  \n default_vhost: $default_vhost  \n ",
	  }
	   
	
	  #########################
	  # set repositories
	  #########################
	
	  zend_server::repo { 'repo':
	    zs_version   => $zs_version,
	    # subscribe => Notify['variables'],
	  }
	
	  ############################
	  # set Package and install
	  ############################
	
	  zend_server::package { 'package':
	    zs_version     => $zs_version,
	    php_version => $php_version,
	    nginx       => $nginx,
	    # subscribe   => Zendserver::Repo['repo'],
	  }
	
	  # #########################
	  #  Set configuration
	  ###########################
	
	  class { 'config':
	    install_path  => $install_path,
	    default_vhost => $default_vhost,
	    # subscribe     => Zendserver::Package['package'],
	  }
	
	  Notify['variables']->Zend_server::Repo['repo']->Zend_server::Package['package']->Class['config']
}