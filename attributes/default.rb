override['storage'] = node['logserver']['storage']
override['et_elk']['storage_type'] = 'ebs'

override['et_consul']['client']['definitions']['logs-search'] = {
  type: 'service',
  parameters: {
    port: 9200,
    tags: %w(logs-search),
    check: {
      interval: '10s',
      timeout: '5s',
      http: 'http://localhost:9200/'
    }
  }
}
