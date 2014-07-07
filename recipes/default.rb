#
# Cookbook Name:: logserver
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#
case node['platform_family']
when 'debian'
  include_recipe 'apt'
end

include_recipe 'elasticsearch'
include_recipe 'logstash::server'
include_recipe 'logstash::agent'

begin
  t = resources(template: '/etc/logrotate.d/logstash')
  t.action :nothing
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn 'Could not find template for ' \
    '"/etc/logrotate.d/logstash" to modify'
end

include_recipe 'logserver::ui'
include_recipe 'logrotate'
include_recipe 'rsyslog::server'

begin
  %w(
    /etc/rsyslog.d/35-server-per-host.conf
  ).each do |conf_file|
    t = resources(template: conf_file)
    t.cookbook cookbook_name.to_s
  end
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "Could not find template for #{conf_file} to modify"
end
