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