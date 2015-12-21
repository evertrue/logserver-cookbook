#
# Cookbook Name:: logserver
# Recipe:: configure
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

instance_name = 'server'

################
# Certificates #
################
include_recipe 'logserver::certs'

############
# Patterns #
############
instance_basedir = node['logstash']['instance_default']['basedir']

cookbook_file "#{instance_basedir}/#{instance_name}/patterns/evertrue_patterns" do
  owner node['logstash']['instance_default']['user']
  group node['logstash']['group']
  notifies :restart, "logstash_service[#{instance_name}]"
end

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
    notifies :restart, "logstash_service[#{instance_name}]"
  end
end
