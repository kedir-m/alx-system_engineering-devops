# configures server using puppet

exec {'/usr/bin/env apt-get -y update': }
exec {'/usr/bin/env apt-get -y install nginx': }
exec {'/usr/bin/env echo "Hello World!" > /var/www/html/index.html': }
exec {'/usr/bin/env sed -i "/server_name _;/ a\\\trewrite ^/redirect_me http://www.holbertonschool.com permanent;" /etc/nginx/sites-available/default': }
exec {'/usr/bin/env echo "Ceci n\'est pas une page" > /var/www/html/c_404.html': }
exec {'/usr/bin/env sed -i "/server_name _;/ a\\\terror_page 404 /c_404.html;" /etc/nginx/sites-available/default': }
exec {'/usr/bin/env service nginx start': }
