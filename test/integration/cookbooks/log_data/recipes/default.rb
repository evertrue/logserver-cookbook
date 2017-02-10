wait_time = 20

ruby_block('wait #{wait_time} seconds') { block { sleep wait_time } }

directory '/var/log/zookeeper'

execute 'fake zookeeper logs' do
  command "cat >> /var/log/zookeeper/zookeeper.log << EOF
#{Time.now.strftime('%Y-%m-%d %H:%M:%S,%3N')} [myid:254] - INFO  [NIOServerCxn.Factory:0.0.0.0/0.0.0.0:2181:NIOServerCnxnFactory@192] - TEST_ZK_LOG_MESSAGE
#{Time.now.strftime('%Y-%m-%d %H:%M:%S,%3N')} [myid:254] - WARN  [NIOServerCxn.Factory:0.0.0.0/0.0.0.0:2181:NIOServerCnxn@357] - caught test exception
EndOfStreamException: Unable to read additional data from client sessionid 0x0, likely client has closed socket
  at org.apache.zookeeper.server.NIOServerCnxn.doIO(NIOServerCnxn.java:228)
  at org.apache.zookeeper.server.NIOServerCnxnFactory.run(NIOServerCnxnFactory.java:203)
  at java.lang.Thread.run(Thread.java:701)
EOF"
  notifies :restart, 'service[logstash]', :before if (
    begin
      resources(service: 'logstash')
    rescue Chef::Exceptions::ResourceNotFound
      false
    end
  )
end

execute 'log some stuff' do
  command "logger -t test-log 'TEST_LOG_MESSAGE'"
  action :run
  notifies :restart, 'service[rsyslog]', :before
  notifies :restart, 'service[logstash]', :before if (
    begin
      resources(service: 'logstash')
    rescue Chef::Exceptions::ResourceNotFound
      false
    end
  )
end
