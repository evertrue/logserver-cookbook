#
# Cookbook Name:: logserver
# Recipe:: configure
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

instance_name = 'server'

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

instance_basedir = node['logstash']['instance_default']['basedir']

###########
# Filters #
###########
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
  cookbook_file "#{instance_basedir}/#{instance_name}/etc/conf.d/filter_#{filter}" do
    owner node['logstash']['instance_default']['user']
    group node['logstash']['group']
    mode  0644
  end
end
