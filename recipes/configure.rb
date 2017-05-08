#
# Cookbook Name:: logserver
# Recipe:: configure
#
# Copyright (c) 2015 EverTrue, inc, All Rights Reserved.

################
# Certificates #
################
include_recipe 'logserver::certs'

############
# Patterns #
############
directory '/etc/logstash/patterns' do
  owner 'logstash'
  group 'logstash'
  mode   0755
  action :create
end

cookbook_file '/etc/logstash/patterns/evertrue_patterns' do
  owner 'logstash'
  group 'logstash'
  notifies :restart, 'service[logstash]'
end

###########
# Filters #
###########
%w(
  000_common
  cassandra_system
  elasticsearch
  syslog
  rails_app
  java
  haproxy_http
  nginx
  mesos
  sidekiq
  zookeeper
).each do |filter|
  cookbook_file "/etc/logstash/conf.d/filter_#{filter}" do
    owner 'logstash'
    group 'logstash'
    notifies :restart, 'service[logstash]'
  end
end
