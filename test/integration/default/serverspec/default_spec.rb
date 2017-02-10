require 'spec_helper'
require 'json'
require 'yaml'
require 'net/http'

describe 'et_elk::default' do
  describe 'cluster' do
    before do
      # Kibana creates an index with a "number_of_replicas" value of 1, which
      # causes the cluster to show yellow on a 1 server setup (like our test
      # environment), so here we change the setting for that one index
      uri = URI('http://localhost:9200/kibana-int/_settings')
      req = Net::HTTP::Put.new uri
      req.body = { 'number_of_replicas' => 0 }.to_json
      req.content_type = 'application/json'
      Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
    end

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

    describe 'syslog' do
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

    describe 'zookeeper' do
      result = JSON.parse(
        Net::HTTP.get(
          URI(
            "http://localhost:9200/logstash-#{index_date}/_search" \
            '?q=type:zookeeper%20AND%20message:TEST_ZK_LOG_MESSAGE'
          )
        )
      )

      it 'inserted into Elasticsearch' do
        expect(result['hits']['hits'].first['_source']['message']).to match(/TEST_ZK_LOG_MESSAGE/)
      end

      it 'contains the right fields' do
        required_fields = %w(
          x_input_processor
          x_proccessed_by
          x_proccessor_chef_env
          myid
          level
          thread
        )
        expect(required_fields - result['hits']['hits'].first['_source'].keys).to eq []
      end

      it 'did not fail the grok parse' do
        expect(
          result['hits']['hits'].first['_source']['tags'] &&
            result['hits']['hits'].first['_source']['tags'].include?('_grokparsefailure')
        ).to eq (false||nil)
      end
    end
  end

  describe 'services' do
    %w(elasticsearch logstash).each do |svc|
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
      zookeeper
    ).each do |conf_file|
      describe file("/etc/logstash/conf.d/filter_#{conf_file}") do
        it { is_expected.to be_file }
        its(:content) { should match 'filter' }
      end
    end

    describe command('/opt/logstash/bin/logstash -f ' \
                     '/etc/logstash/conf.d/ --configtest') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(/Configuration OK/) }
    end
  end
end

describe 'logserver::configure' do
  let(:es_yaml) { YAML.load_file '/etc/elasticsearch/elasticsearch.yml' }

  it 'set data path to EBS volume' do
    expect(es_yaml['path.data']).to eq '/mnt/ebs0/elasticsearch/data'
  end
end

describe 'storage' do
  describe file '/mnt/ebs0' do
    it { is_expected.to be_mounted.with device: '/dev/xvde' }
  end
end
