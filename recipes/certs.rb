ssl_object = data_bag_item(
  node['logserver']['certs']['data_bag'],
  node['logserver']['certs']['data_bag_item']
)['data']

directory '/etc/logstash' do
  recursive true
end

key = '/etc/logstash/lumberjack.key.pem'
certificate = '/etc/logstash/lumberjack.crt.pem'

file key do
  content "#{ssl_object['key']}\n"
  sensitive true
  user node['logstash']['instance_default']['user']
  group node['logstash']['group']
  mode 0600
  notifies :restart, 'logstash_service[server]'
end

if node['logserver']['generate_cert']
  openssl_x509 certificate do
    common_name node['fqdn']
    org node['logserver']['certs']['self_signed']['org']
    org_unit node['logserver']['certs']['self_signed']['org_unit']
    country node['logserver']['certs']['self_signed']['country']
    expire 30
    key_file key
    notifies :restart, 'logstash_service[server]'
  end
else
  file certificate do
    content "#{ssl_object['certificate']}\n"
    user node['logstash']['instance_default']['user']
    group node['logstash']['group']
    notifies :restart, 'logstash_service[server]'
  end
end
