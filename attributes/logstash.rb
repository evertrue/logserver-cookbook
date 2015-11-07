
# All this junk needs to be updated

default['logserver']['cert_data_bag'] = 'certificates'
default['logserver']['cert_data_bag_item'] = 'logstash'

default['logserver']['lumberjack']['ssl certificate'] = '/etc/logstash/lumberjack.crt.pem'
default['logserver']['lumberjack']['ssl key'] = '/etc/logstash/lumberjack.key.pem'
