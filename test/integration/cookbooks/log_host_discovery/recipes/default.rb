port = node['et_elk']['server']['config']['input']['beats']['port']
node.set['filebeat']['config']['output']['logstash']['hosts'] = ["#{node['fqdn']}:#{port}"]
