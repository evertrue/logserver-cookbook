set['rsyslog']['log_dir'] = '/var/log/rsyslog'
set['rsyslog']['high_precision_timestamps'] = true
default['rsyslog']['default_file_create_mode'] = '0644'
default['rsyslog']['default_dir_create_mode'] = '0755'
default['rsyslog']['default_format'] = 'RSYSLOG_SyslogProtocol23Format'
