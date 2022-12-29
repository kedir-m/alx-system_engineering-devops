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
  command  => 'echo "Hello World!" > /var/www/html/index.html',
}
exec {'custom 404':
  command  => 'echo "Ceci n\'est pas une page" > /var/www/html/c_404.html',
}
exec {'custom_404 cnf':
  command  => 'sed -i "/redirect_me/a \\\terror_page 404 /c_404.html;" /etc/nginx/sites-available/default',
}
exec {'redirect me':
  command  => 'sed -i "/server_name _;/ a\\\trewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default',
}
exec {'add_header':
  environment => ["HOST=${hostname}"],
  command     => 'sed -i "s/include \/etc\/nginx\/sites-enabled\/\*;/include \/etc\/nginx\/sites-enabled\/\*;\n\tadd_header X-Served-By \"$HOST\";/" /etc/nginx/nginx.conf',
  before      => Exec['restart Nginx'],
}
exec {'restart Nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
}
