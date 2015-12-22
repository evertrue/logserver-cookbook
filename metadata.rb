name             'logserver'
maintainer       'EverTrue, Inc'
maintainer_email 'devops@evertrue.com'
license          'all_rights'
description      'Installs/Configures logserver'
long_description 'Installs/Configures logserver'
version          '2.0.0'

supports 'ubuntu', '>= 14.04'

depends 'et_elk', '~> 3.0'
depends 'openssl', '~> 4.4'

provides 'logserver'
