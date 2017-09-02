#
# Cookbook:: nginx
# Spec:: reverse_proxy
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nginx::reverse_proxy' do
  context 'When all attributes are default, on a centos 7.2 box' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs epel-release' do
      expect(chef_run).to install_package('epel-release')
    end

    it 'installs nginx' do
      expect(chef_run).to install_package('nginx')
    end

    it 'provisions sites-available/default file correctly' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/default').
        with(
          user: 'root',
          group: 'root',
          mode: '0755',
        )
    end

    it 'enables nginx service' do
      expect(chef_run).to enable_service('nginx')
    end

    it 'starts nginx service' do
      expect(chef_run).to start_service('nginx')
    end
  end

  context 'When all attributes are default, on an ubuntu 16.04 box' do
    let(:platform) { 'ubuntu' }
    let(:version) { '16.04' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'does not install epel-release' do
      expect(chef_run).to_not install_package('epel-release')
    end

    it 'installs nginx' do
      expect(chef_run).to install_package('nginx')
    end

    it 'provisions sites-available/default file correctly' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/default').
        with(
          user: 'root',
          group: 'root',
          mode: '0755',
        )
    end

    it 'enables nginx service' do
      expect(chef_run).to enable_service('nginx')
    end

    it 'starts nginx service' do
      expect(chef_run).to start_service('nginx')
    end
  end
end
