execute 'log some stuff' do
  command "logger -t test-log 'TEST_LOG_MESSAGE'"
  action  :run
end
