name             'logserver'
maintainer       'EverTrue, Inc.'
maintainer_email 'eric.herot@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures logserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

depends 'apt'
depends 'redis'
depends 'kibana'
depends 'elasticsearch'
depends 'logrotate'
depends 'logstash'
depends 'rsyslog'

provides 'logserver'
