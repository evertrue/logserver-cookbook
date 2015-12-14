#
# Cookbook Name:: logserver
# Recipe:: certs
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

ssl_object = data_bag_item(
  node['logserver']['certs']['data_bag'],
  node['logserver']['certs']['data_bag_item']
)['data']

directory '/etc/logstash' do
  recursive true
end

key = node['et_elk']['server']['config']['input']['lumberjack']['ssl_key']
certificate = node['et_elk']['server']['config']['input']['lumberjack']['ssl_certificate']

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
    not_if { ::File.exist? certificate } # Necessary because of a bug in openssl_x509
  end
else
  file certificate do
    content "#{ssl_object['certificate']}\n"
    user node['logstash']['instance_default']['user']
    group node['logstash']['group']
    notifies :restart, 'logstash_service[server]'
  end
end
