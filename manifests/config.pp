class config (
    $install_path,
    $default_vhost,
    $adminPassword,
    $devPassword,
    $orderNumber,
    $licenseKey,
    $acceptEula,
    $appUrl,
    $production ) {

    $order = $orderNumber ? {
        '' => '',
        default => "--orderNumber ${orderNumber} --licenseKey ${licenseKey} "
    }
    $command = "/usr/local/zend/bin/zs-manage bootstrap-single-server --adminPassword ${adminPassword} --devPassword ${devPassword} ${order}--acceptEula ${acceptEula} --appUrl ${appUrl} --production ${production}"

    file_line { "profile":
        path => '/etc/profile',
        line => "PATH=\$PATH:${install_path}/bin \n LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:${install_path}/lib",
    }

    file_line { "defaultvhost":
        path => "${default_vhost}",
        #match => "root *$",
        line => "root /usr/share/nginx/html;",
        ensure => absent,
        notify => Service['zend-server'],
    }
    service {"zend-server":
        ensure => "running",
    }
    
    exec { "zend-serverconfig":
        command => $command,
    }
  
    File_Line['profile']->File_Line['defaultvhost']->Service['zend-server']->Exec['zend-serverconfig']
  
#  case $orderNumber {
#    '': {
#      $command = "/usr/local/zend/bin/zs-manage bootstrap-single-server --adminPassword ${adminPassword} --devPassword ${devPassword}--acceptEula ${acceptEula} --appUrl ${appUrl} --production ${production}"
#      exec { "zserverconfig":
#        command => $command,
#      }
#    }
#    default: {
#      $order = "--orderNumber ${orderNumber} --licenseKey ${licenseKey} "
#      
#      $command = "/usr/local/zend/bin/zs-manage bootstrap-single-server --adminPassword ${adminPassword} --devPassword ${devPassword} ${order}--acceptEula ${acceptEula} --appUrl ${appUrl} --production ${production}"
#      
#      exec { "zserverconfig":
#        command => $command,
#      }
#    }
#  }
  
}