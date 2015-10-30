require 'spec_helper'

describe 'et_elk::default' do
  describe 'filter config' do
    describe command('/opt/logstash/server/bin/logstash -f ' \
                     '/opt/logstash/server/etc/conf.d/ --configtest') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(/Configuration OK/) }
    end

    %w(
      filter_000_common
      filter_haproxy_http
      filter_java
      filter_mesos
      filter_nginx
      filter_rails_app
      filter_syslog
      input_lumberjack
      output_elasticsearch
    ).each do |conf_file|
      describe file("/opt/logstash/server/etc/conf.d/#{conf_file}") do
        it { is_expected.to be_file }
      end
    end

    %w(
      filter_000_common
      filter_haproxy_http
      filter_java
      filter_mesos
      filter_nginx
      filter_rails_app
      filter_syslog
    ).each do |filter_conf|
      describe file("/opt/logstash/server/etc/conf.d/#{filter_conf}") do
        its(:content) { should match 'filter' }
      end
    end

    describe command('/opt/logstash/server/bin/logstash -f ' \
                     '/opt/logstash/server/etc/conf.d/ --configtest') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(/Configuration OK/) }
    end
  end
end
