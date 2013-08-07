#
# Cookbook Name:: logserver
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
# 
# All rights reserved - Do Not Redistribute
#
case node['platform_family']
  when "debian"
   include_recipe "apt"
end

include_recipe "redis::server"
include_recipe "elasticsearch"
include_recipe "logstash::server"
include_recipe "kibana"
include_recipe "logrotate"

logrotate_app "redis_server" do
  path node['redis']['config']['logfile']
  frequency "daily"
  rotate "10"
end

if node['logstash']['server']['init_method'] == 'runit'
  include_recipe "runit"
  service_resource = 'runit_service[logstash_server]'
else
  service_resource = 'service[logstash_server]'
end

if Chef::Config[:solo]
  es_server_ip = node['logstash']['elasticsearch_ip']
  graphite_server_ip = node['logstash']['graphite_ip']
else
  es_results = search(:node, node['logstash']['elasticsearch_query'])
  graphite_results = search(:node, node['logstash']['graphite_query'])

  unless es_results.empty?
    es_server_ip = es_results[0]['ipaddress']
  else
    es_server_ip = node['logstash']['elasticsearch_ip']
  end

  unless graphite_results.empty?
    graphite_server_ip = graphite_results[0]['ipaddress']
  else
    graphite_server_ip = node['logstash']['graphite_ip']
  end
end

# Overriding the logstash.conf template because the original doesn't allow
# more than one filter directive with the same name.

template "#{node['logstash']['basedir']}/server/etc/conf.d/syslog.conf" do
  source "syslog.conf.erb"
  owner node['logstash']['user']
  group node['logstash']['group']
  mode "0644"
  variables(:graphite_server_ip => graphite_server_ip,
            :es_server_ip => es_server_ip,
            :enable_embedded_es => node['logstash']['server']['enable_embedded_es'],
            :es_cluster => node['logstash']['elasticsearch_cluster'])
  notifies :restart, service_resource
  action :create
end
