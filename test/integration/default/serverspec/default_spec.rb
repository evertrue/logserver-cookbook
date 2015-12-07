require 'spec_helper'
require 'json'
require 'net/http'

describe 'et_elk::default' do
  describe 'cluster' do
    it 'shows green status' do
      expect(
        JSON.parse(
          Net::HTTP.get(
            URI('http://localhost:9200/_cluster/health')
          )
        )['status']
      ).to eq 'green'
    end
  end

  describe 'log data' do
    it 'inserted into Elasticsearch' do
      index_date = Time.now.strftime '%Y.%m.%d'
      expect(
        JSON.parse(
          Net::HTTP.get(
            URI(
              "http://localhost:9200/logstash-#{index_date}/_search" \
              '?q=message:TEST_LOG_MESSAGE'
            )
          )
        )['hits']['hits'].first['_source']['message']
      ).to match(/TEST_LOG_MESSAGE/)
    end
  end

  describe 'filter config' do
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
