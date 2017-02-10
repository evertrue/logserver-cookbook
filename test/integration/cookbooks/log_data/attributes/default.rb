default['filebeat']['prospectors']['zookeeper']['filebeat']['prospectors'] = [
  {
    'paths' => ['/var/log/zookeeper/zookeeper.log'],
    'input_type' => 'log',
    'document_type' => 'zookeeper'
  }
]
