name             'logserver'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures logserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.6.1'

depends 'apt'
depends 'java'
depends 'kibana', '= 1.2.1'
depends 'htpasswd'
depends 'elasticsearch', '= 0.3.10'
depends 'logrotate'
depends 'logstash', '= 0.8.1'
depends 'rsyslog', '~> 1.12.2'

provides 'logserver'
