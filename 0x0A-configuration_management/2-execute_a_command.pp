# kills process named killmenow

exec {'pkill':
  command  => '/usr/bin/pkill killmenow'
  provider => 'shell'
}
