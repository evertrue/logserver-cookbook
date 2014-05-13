set['kibana']['webserver_listen'] = '0.0.0.0'

set['kibana']['file']['url'] = 'http://ops.evertrue.com.s3.amazonaws.com/pkgs/kibana-3.0.0milestone5.zip'
set['kibana']['file']['checksum'] = '8c821442293c258c07df426502327387e64ffb28f5d9b1d44dcfa3160c7db339'

default['kibana']['default_dashboard'] = 'evertrue-logstash.json'
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
