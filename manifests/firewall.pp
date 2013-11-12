define zend_server::firewall () {

	include firewall 

	firewall { '100 allow http and https access':
		port   => [80, 443],
		proto  => tcp,
		action => accept,
	}

	firewall { '100 allow zend server gui http and https access':
		port   => [10081, 10082],
		proto  => tcp,
		action => accept,
	}	  



    # firewall { "zendserver_tcp_10081":
    #   source        => $zendserver::firewall_src,
    #   destination   => $zendserver::firewall_dst,
    #   protocol      => 'tcp',
    #   port          => 10081,
    #   action        => 'allow',
    #   direction     => 'input',
    #   tool          => $zendserver::firewall_tool,
    #   enable        => $zendserver::manage_firewall,
    # }
    
    # firewall { "zendserver_tcp_10082":
    #   source        => $zendserver::firewall_src,
    #   destination   => $zendserver::firewall_dst,
    #   protocol      => 'tcp',
    #   port          => 10082,
    #   action        => 'allow',
    #   direction     => 'input',
    #   tool          => $zendserver::firewall_tool,
    #   enable        => $zendserver::manage_firewall,
    # }
  }