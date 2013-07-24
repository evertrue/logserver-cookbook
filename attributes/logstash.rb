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
  }
]