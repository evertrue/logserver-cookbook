ruby_block('wait 10 seconds') { block { sleep 10 } }

execute 'log some stuff' do
  command "logger -t test-log 'TEST_LOG_MESSAGE'"
  action :run
  notifies :run, 'ruby_block[wait 10 seconds]' # Give filebeats some time to pick them up
end
