#
# Cookbook Name:: logserver
# Recipe:: configure
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

instance_name = 'server'
instance_conf_dir =
  "#{node['logstash']['instance'][instance_name]['basedir']}/" \
  "#{instance_name}/etc/conf.d"

node.set['logstash']['instance'][instance_name]['config_templates_cookbook'] =
  cookbook_name
node.set['logstash']['instance'][instance_name]['pattern_templates_cookbook'] =
  cookbook_name

################
# Certificates #
################
include_recipe 'logserver::certs'

############
# Patterns #
############
logstash_pattern 'evertrue patterns' do
  templates 'evertrue_patterns' => 'evertrue_patterns.erb'
  instance instance_name
end

############
#  Inputs  #
############
logstash_config 'lumberjack input' do
  templates 'input_lumberjack' => 'input_lumberjack.erb'
  instance instance_name
  variables node['logserver']
  notifies :restart, "logstash_service[#{instance_name}]"
end

logstash_config 'log4j input' do
  templates 'input_log4j' => 'input_log4j.erb'
  instance instance_name
  variables node['logserver']
  notifies :restart, "logstash_service[#{instance_name}]"
end

############
# Filters  #
############
%w(
  000_common
  syslog
  rails_app
  java
  haproxy_http
  nginx
  mesos
  sidekiq
).each do |filter|
  cookbook_file "#{instance_conf_dir}/filter_#{filter}" do
    owner node['logstash']['instance_default']['user']
    group node['logstash']['group']
    mode  0644
  end
end

############
# Outputs  #
############
logstash_config 'elasticsearch output' do
  templates 'output_elasticsearch' => 'output_elasticsearch.erb'
  instance instance_name
  variables node['et_elk'][instance_name]
  notifies :restart, "logstash_service[#{instance_name}]"
end
