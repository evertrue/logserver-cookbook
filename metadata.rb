name             'logserver'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures logserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.3.1'

depends 'apt'
depends 'redis'
depends 'kibana'
depends 'htpasswd'
depends 'elasticsearch'
depends 'logrotate'
depends 'logstash'
depends 'rsyslog'

provides 'logserver'
