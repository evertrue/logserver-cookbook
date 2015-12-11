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
    index_date = Time.now.strftime '%Y.%m.%d'
    result = JSON.parse(
      Net::HTTP.get(
        URI(
          "http://localhost:9200/logstash-#{index_date}/_search" \
          '?q=message:TEST_LOG_MESSAGE'
        )
      )
    )

    it 'inserted into Elasticsearch' do
      expect(result['hits']['hits'].first['_source']['message']).to match(/TEST_LOG_MESSAGE/)
    end

    it 'contains the right fields' do
      required_fields = %w(
        x_input_processor
        x_proccessed_by
        x_proccessor_chef_env
      )
      expect(required_fields - result['hits']['hits'].first['_source'].keys).to eq []
    end
  end

  describe 'services' do
    %w(elasticsearch logstash_server).each do |svc|
      describe service(svc) do
        it { is_expected.to be_running }
      end
    end

    [9200, 9300, 5601].each do |cur_port|
      describe port(cur_port) do
        it { is_expected.to be_listening.with('tcp') }
      end
    end

    [5043, 5044].each do |cur_port|
      describe port(cur_port) do
        it { is_expected.to be_listening.with('tcp6') }
      end
    end
  end

  describe 'filter config' do
    %w(
      000_common
      haproxy_http
      java
      mesos
      nginx
      rails_app
      syslog
    ).each do |conf_file|
      describe file("/opt/logstash/server/etc/conf.d/filter_#{conf_file}") do
        it { is_expected.to be_file }
        its(:content) { should match 'filter' }
      end
    end

    describe command('/opt/logstash/server/bin/logstash -f ' \
                     '/opt/logstash/server/etc/conf.d/ --configtest') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(/Configuration OK/) }
    end
  end

  describe 'input/output config' do
    %w(
      input_lumberjack
      output_elasticsearch
    ).each do |conf_file|
      describe file("/opt/logstash/server/etc/conf.d/#{conf_file}") do
        it { is_expected.to be_file }
      end
    end
  end
end
