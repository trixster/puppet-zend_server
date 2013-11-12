class zend_server::service {

    service { "zend-server":
        ensure => "running",
        hasstatus => true,
        hasrestart => true,
        enable => true,
        require => Class["zend_server"],
        provider => "init",
    }
}