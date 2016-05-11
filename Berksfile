source 'https://berks.evertrue.com'
source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'et_elk', path: '../et_elk'
  cookbook 'et_logger', path: '../et_logger'
  cookbook 'rsyslog', path: '../../../other/rsyslog'
  cookbook 'log_data', path: 'test/integration/cookbooks/log_data'
  cookbook 'log_host_discovery', path: 'test/integration/cookbooks/log_host_discovery'
  cookbook 'logserver_postop', path: 'test/integration/cookbooks/logserver_postop'
end
