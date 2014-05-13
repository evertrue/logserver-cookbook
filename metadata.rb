name             'logserver'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures logserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.6.0'

depends 'apt'
depends 'redis'
depends 'kibana', '~> 1.2.0'
depends 'htpasswd'
depends 'elasticsearch'
depends 'logrotate'
depends 'logstash'
depends 'rsyslog', '~> 1.12.2'

provides 'logserver'
