#
# Cookbook Name:: logserver
# Spec:: default
#
# Copyright 2015 EverTrue, inc.
## Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
##     http://www.apache.org/licenses/LICENSE-2.0
## Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'

describe 'logserver::default' do
  before do
    Fauxhai.mock(platform: 'ubuntu', version: '14.04')
  end

  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node, server|
        node.automatic['memory'] = { 'total' => '1692536kB' }
        Dir.glob('test/integration/default/data_bags/**/*.json').each do |item|
          bag = File.basename(File.dirname(item))
          server.create_data_bag(bag, JSON.parse(File.read(item)))
        end

        Dir.glob('test/integration/default/nodes/*.json').each do |item|
          name = File.basename(item, '.json')
          server.create_node(name, JSON.parse(File.read(item)))
        end
      end
      runner.converge(described_recipe)
    end
    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end
