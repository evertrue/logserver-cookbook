wait_time = 20

ruby_block('wait #{wait_time} seconds') { block { sleep wait_time } }

execute 'log some stuff' do
  command "logger -t test-log 'TEST_LOG_MESSAGE'"
  action :run
  notifies :restart, 'service[rsyslog]', :before
  notifies :run, "ruby_block[wait #{wait_time} seconds]" # Give filebeats some time to pick them up
end
