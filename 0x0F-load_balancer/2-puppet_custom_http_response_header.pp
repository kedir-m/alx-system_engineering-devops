# installs nginx server with custome HTTP header

exec {'update':
  provider => shell,
  command  => 'sudo apt-get -y update',
  before   => Exec['install Nginx'],
}

exec {'install Nginx':
  provider => shell,
  command  => 'sudo apt-get -y install nginx'
  before   => Exec['hello world']
}
exec {'hello world!':
  provider => shell,
  command  => 'echo "Hello World!" > /var/www/html/index.html',
}
exec {'custom 404':
  provider => shell,
  command  => 'echo "Ceci n\'est pas une page" > /var/www/html/c_404.html',
}
exec {'custom_404 cnf':
  provider => shell,
  command  => 'sed -i "/redirect_me/a \\\terror_page 404 /c_404.html;" /etc/nginx/sites-available/default',
}
exec {'redirect me':
  provider => shell,
  command  => 'sed -i "/server_name _;/ a\\\trewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default',
}
exec {'add_header':
  provider    => shell,
  environment => ["HOST=${hostname}"],
  command     => 'sudo sed -i "s/include \/etc\/nginx\/sites-enabled\/\*;/include \/etc\/nginx\/sites-enabled\/\*;\n\tadd_header X-Served-By \"$HOST\";/" /etc/nginx/nginx.conf',
  before      => Exec['restart Nginx'],
}
exec {'restart Nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
}
