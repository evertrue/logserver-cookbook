set['kibana']['branch'] = "v3.0.0milestone2"

set['kibana']['webserver_listen'] = "0.0.0.0"
default['kibana']['default_dashboard'] = "evertrue-logstash.json"
default['kibana']['dashboard_conf'] = {
  'time_field' => "@fields.syslog5424_ts",
  'dashboards' => {
    'events' => {
      'sort_field' => "@fields.syslog5424_ts",
      'fields' => [
        '@fields.syslog5424_pri',
        '@fields.syslog5424_ts',
        '@fields.syslog5424_host',
        '@fields.syslog5424_app',
        '@fields.syslog5424_proc',
        '@fields.syslog_severity',
        '@fields.syslog5424_msg'
      ]
    }
  }
}

default['loadbalancer'] = {
  "app_family" => "ops",
  "acls" => {
    "host_logs" => {
      "type" => "hdr_beg(host)",
      "match" => "logs.evertrue.com"
    }
  },
  "applications" => {
    "logs" => {
      "acls" => [[ "host_logs" ]],
      "ssl_enabled" => true,
      "ssl_required" => true
    }
  },
  "backends" => {
    "logs" => {
      "balance_algorithm" => "roundrobin",
      "check_req" => { "always" => true },
      "port" => "80"
    }
  }
}
