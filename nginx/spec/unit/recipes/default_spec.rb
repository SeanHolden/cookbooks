#
# Cookbook:: nginx
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nginx::default' do
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

    describe 'directories' do
      it 'provisions /var/www directory correctly' do
        expect(chef_run).to create_directory('/var/www').with(
          user: 'vagrant',
          group: 'vagrant',
          mode: '0755',
        )
      end

      it 'sets /var/www/html up as a symlink to /vagrant' do
        expect(chef_run).to create_link('/var/www/html').with(
          link_type: :symbolic,
          to: '/vagrant',
        )
      end
    end

    it 'installs epel-release' do
      expect(chef_run).to install_package('epel-release')
    end

    it 'installs nginx' do
      expect(chef_run).to install_package('nginx')
    end

    it 'provisions nginx.conf file correctly' do
      expect(chef_run).to create_template('/etc/nginx/nginx.conf').with(
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
