set['kibana']['webserver_listen'] = "0.0.0.0"
default['kibana']['default_dashboard'] = "evertrue-logstash.json"
default['kibana']['dashboard_conf'] = {
  'time_field' => '@fields.syslog5424_ts',
  'dashboards' => {
    'events' => {
      'sort_field' => '@fields.syslog5424_ts',
      'fields' => [
        '@fields.syslog5424_ts',
        '@fields.syslog5424_host',
        '@fields.syslog5424_app',
        '@fields.syslog_severity',
        '@fields.syslog5424_msg'
      ]
    }
  }
}
set['kibana']['install_type'] = 'file'
