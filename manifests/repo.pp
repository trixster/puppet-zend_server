define zend_server::repo (
  $zs_version = 'UNSET') {
  
  # notify {"Version in repo: ${zs_version}":}
  
  case $::osfamily {
  # debian, ubuntu
  'debian': {
    class { 'apt': }

  include apt
  
  # set repo URLs based on zs_version
  $repo = "http://repos.zend.com/zend-server/${zs_version}/deb"
  $repo_ssl = "${repo}_ssl1.0"

  # add repo and key 
  apt::source { 'zendserverrepo':
    include_src => false,
    location    => $repo,
    release     => 'server',
    repos       => 'non-free',
    key         => 'F7D2C623',
    key_server  => 'http://repos.zend.com/zend.key',
  }


} 
  # redhat, centos
  'redhat': {
    class { 'yum': extrarepo => ['epel'] }

    # Class['::yum'] -> Yum::Managed_yumrepo :
    yum::managed_yumrepo {

      'Zend':
         descr          => 'zend-server',
         baseurl        => "http://repos.zend.com/zend-server/${zs_version}/rpm/\$basearch",
         enabled        => 1,
         gpgcheck       => 1,
         gpgkey         => 'http://repos.zend.com/zend.key';

      'Zend_noarch':
         descr          => 'zend-server - noarch',
         baseurl        => "http://repos.zend.com/zend-server/${zs_version}/rpm/noarch",
         enabled        => 1,
         gpgcheck       => 1,
         gpgkey         => 'http://repos.zend.com/zend.key';
    }

}


#  # add ssl repo and key
#  # @TODO: fix, breaks on debian (dependency cycle)
#  apt::source { 'zendserverrepossl':
#    include_src => false,
#    location    => $repo_ssl,
#    release     => 'server',
#    repos       => 'non-free',
#    key         => 'F7D2C623',
#    key_server  => 'http://repos.zend.com/zend.key',
#  }

}
}