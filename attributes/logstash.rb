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
    'host' => ['dev-logstash.vwbbgm.0001.use1.cache.amazonaws.com'],
    'data_type' => 'list',
    'key' => 'logstash',
    'batch' => 'true'
  }
]

set['logstash']['server']['inputs'] = [
  'redis' => {
    'type' => 'redis-input',
    'host' => 'dev-logstash.vwbbgm.0001.use1.cache.amazonaws.com',
    'data_type' => 'list',
    'key' => 'logstash',
    'codec' => 'json'
  },
  'udp' => {
    'codec' => 'json',
    'host' => '0.0.0.0',
    'port' => '5228',
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
    condition: 'if [type] == "logstash-logger"',
    block: {
      json: {
        source: 'message'
      }
    }
  },
  {
    condition: 'if [type] == "rsyslog23"',
    block: {
      grok: {
        match: ['message', '%{SYSLOG23LINE}'],
        add_field: ['received_at', '%{@timestamp}'],
        add_field: ['received_from', '%{@source_host}']
      },
      syslog_pri: {
        syslog_pri_field_name: 'syslog5424_pri'
      },
      date: {
        match: ['syslog5424_ts', 'ISO8601']
      }
    }
  }
]
