default['logserver']['cert_data_bag'] = 'certificates'
default['logserver']['cert_data_bag_item'] = 'logstash'

default['logserver']['lumberjack']['ssl certificate'] = '/etc/logstash/lumberjack.crt.pem'
default['logserver']['lumberjack']['ssl key'] = '/etc/logstash/lumberjack.key.pem'
default['logserver']['lumberjack']['codec'] = 'plain'
default['logserver']['lumberjack']['host'] = '0.0.0.0'
default['logserver']['lumberjack']['port'] = 5043

default['logserver']['log4j']['data_timeout'] = 5
default['logserver']['log4j']['host'] = '0.0.0.0'
default['logserver']['log4j']['port'] = 5044
default['logserver']['log4j']['mode'] = 'server'

set['et_elk']['logstash']['plugins'] = ['logstash-filter-alter']
