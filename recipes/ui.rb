node.set['kibana']['es_server'] = node['logstash']['elasticsearch_ip']

if node['logstash']['elasticsearch_port'] &&
  node['logstash']['elasticsearch_port'] != ''
  node.set['kibana']['es_port'] = node['logstash']['elasticsearch_port']
end

include_recipe "kibana"

dashboards_dir = "#{node['kibana']['installdir']}/current/dashboards"

if node['kibana']['user'].empty?
  webserver = node['kibana']['webserver']
  kibana_user = "#{node[webserver]['user']}"
else
  kibana_user = node['kibana']['user']
end

template "#{dashboards_dir}/#{node['kibana']['default_dashboard']}" do
  source "evertrue-logstash.json.erb"
  owner kibana_user
  mode 00644
end

file "#{dashboards_dir}/default.json" do
  action :delete
  not_if { File.symlink?("#{dashboards_dir}/default.json") }
end

link "#{dashboards_dir}/default.json" do
  to "#{dashboards_dir}/#{node['kibana']['default_dashboard']}"
  owner kibana_user
end
