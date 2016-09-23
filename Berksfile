source :chef_server
source 'https://supermarket.chef.io'

metadata

group :integration do
  # cookbook 'et_base'
  # cookbook 'et_elk', path: '../et_elk'
  # cookbook 'et_kibana_lwrp', path: '../et_kibana_lwrp'
  cookbook 'aws'
  cookbook 'et_logger', '>= 4.0.0'
  cookbook 'log_data', path: 'test/integration/cookbooks/log_data'
  cookbook 'log_host_discovery', path: 'test/integration/cookbooks/log_host_discovery'
  cookbook 'logserver_postop', path: 'test/integration/cookbooks/logserver_postop'
end
