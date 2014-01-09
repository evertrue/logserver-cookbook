set['logstash']['server']['source_url'] = 'http://ops.evertrue.com.s3.amazonaws.com/pkgs/logstash-1.1.13-flatjar.jar'
set['logstash']['server']['install_rabbitmq'] = false
set['logstash']['server']['enable_embedded_es'] = false

set['logstash']['elasticsearch_ip'] = '127.0.0.1'

set['logstash']['agent']['inputs'] = [
  'file' => {
    'type' => 'rsyslog23',
    'path' => '/var/log/rsyslog/**/*log',
    'start_position' => 'beginning'
  }
]
set['logstash']['agent']['outputs'] = [
  'redis' => {
    'host' => ['127.0.0.1'],
    'data_type' => 'list',
    'key' => 'logstash',
    'batch' => 'true'
  }
]

set['logstash']['server']['inputs'] = [
  'redis' => {
    'type' => 'redis-input',
    'host' => '127.0.0.1',
    'data_type' => 'list',
    'key' => 'logstash',
    'format' => 'json_event'
  },
  'udp' => {
    'format' => 'json_event',
    'host' => '0.0.0.0',
    'type' => 'logstash-logger'
  }
]

set['logstash']['patterns'] = {
  'rsyslog23' => {
    'SYSLOG23LINE' => '(?:\<%{NONNEGINT:syslog5424_pri}\>)%{NONNEGINT:syslog5424_ver} (%{TIMESTAMP_ISO8601:syslog5424_ts}|-) (%{HOSTNAME:syslog5424_host}|-) (%{NOTSPACE:syslog5424_app}|-)( |-)?%{WORD:syslog5424_proc}? (%{WORD:syslog5424_msgid}|-) (?:\[%{DATA:syslog5424_sd}\]+|-) %{GREEDYDATA:syslog5424_msg}'
  }
}

set['logstash']['server']['filters'] = [
  {
    json: {
      source: 'message',
      type: 'logstash-logger'
    }
  },
  {
    grok: {
      type: 'rsyslog23',
      pattern: ['%{SYSLOG23LINE}'],
      add_field: ['received_at', '%{@timestamp}'],
      add_field: ['received_from', '%{@source_host}']
    }
  },
  {
    syslog_pri: {
      type: 'rsyslog23',
      syslog_pri_field_name: 'syslog5424_pri'
    }
  },
  {
    date: {
      type: 'rsyslog23',
      match: ['ISO8601']
    }
  }
]
