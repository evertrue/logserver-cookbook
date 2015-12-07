
node.set['logstash']['instance']['server']['config_templates_cookbook'] =
  cookbook_name
node.set['logstash']['instance']['server']['pattern_templates_cookbook'] =
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
  instance 'server'
end

############
#  Inputs  #
############
logstash_config 'lumberjack input' do
  templates 'input_lumberjack' => 'input_lumberjack.erb'
  instance 'server'
  variables node['logserver']
  notifies :restart, 'logstash_service[server]'
end

logstash_config 'log4j input' do
  templates 'input_log4j' => 'input_log4j.erb'
  instance 'server'
  variables node['logserver']
  notifies :restart, 'logstash_service[server]'
end

############
# Filters  #
############
logstash_config 'common filter' do
  templates 'filter_000_common' => 'filter_common.erb'
  instance 'server'
end

logstash_config 'application filters' do
  # The logstash code insists on having a hash here (rather than an array) even
  # though it works fine without the values, so we set them all to nil.
  templates(
    %w(
      syslog
      rails_app
      java
      haproxy_http
      nginx
      mesos
      sidekiq
    ).each_with_object({}) { |f, m| m["filter_#{f}"] = nil }
  )
  instance 'server'
  notifies :restart, 'logstash_service[server]'
end

############
# Outputs  #
############
logstash_config 'elasticsearch output' do
  templates 'output_elasticsearch' => 'output_elasticsearch.erb'
  instance 'server'
  variables node['et_elk']['server']
  notifies :restart, 'logstash_service[server]'
end
