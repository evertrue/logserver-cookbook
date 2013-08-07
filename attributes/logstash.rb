set['logstash']['server']['install_rabbitmq'] = false
set['logstash']['server']['enable_embedded_es'] = false
set['logstash']['elasticsearch_ip'] = "127.0.0.1"

# Inputs
set['logstash']['server']['inputs'] = [
  'redis' => {
    'type' => 'redis-input',
    'host' => '127.0.0.1',
    'data_type' => 'list',
    'key' => 'logstash',
    'format' => 'json_event'
  },
  'tcp' => {
    'type' => 'syslog',
    'port' => '5544'
  },
  'udp' => {
    'type' => 'syslog',
    'port' => '5544'
  }
]
set['logstash']['server']['filters'] = 'grok {
      type => "syslog",
      pattern => [ "<%{POSINT:syslog_pri}>%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" ],
      add_field => [ "received_at", "%{@timestamp}" ],
      add_field => [ "received_from", "%{@source_host}" ]
  }
  syslog_pri {
      type => "syslog"
  }
  date => {
      type => "syslog",
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
  }
  mutate1 {
      type => "syslog",
      exclude_tags => "_grokparsefailure",
      replace => [ "@source_host", "%{syslog_hostname}" ],
      replace => [ "@message", "%{syslog_message}" ]
  }
  mutate2 {
      type => "syslog",
      remove => [ "syslog_hostname", "syslog_message", "syslog_timestamp" ]
  }'
