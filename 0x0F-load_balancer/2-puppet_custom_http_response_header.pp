# installs nginx server with custome HTTP header

exec {'update':
  provider => shell,
  command  => 'sudo apt-get -y update',
  before   => Exec['install Nginx'],
}

exec {'install Nginx':
  provider => shell,
  command  => 'sudo apt-get -y install nginx',
  before   => Exec['add_header'],
}
exec {'add_header':
  command     => 'sudo sed -i "/listen 80 default_server;/a add_header X-Served-By $HOSTNAME;" /etc/nginx/sites-available/default',

  before      => Exec['restart Nginx'],
}
exec {'restart Nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
}
