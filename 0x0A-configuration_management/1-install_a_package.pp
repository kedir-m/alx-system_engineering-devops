# installs flask version 2.1.0 from pip3 

exec {'install flask':
  command => '/usr/bin/pip3 install flask -v 2.1.0',
  }
