#
# Cookbook Name:: logserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'et_elk::server'

include_recipe 'logserver::configure'
