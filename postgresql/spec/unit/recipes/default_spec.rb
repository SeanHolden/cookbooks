#
# Cookbook:: postgresql
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'postgresql::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    before do
      stub_command('sudo -u postgres psql -c "SELECT * FROM pg_user" | grep postgres').
        and_return(false)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs package postgresql' do
      expect(chef_run).to install_package('postgresql')
    end

    it 'installs package postgresql-libs' do
      expect(chef_run).to install_package('postgresql-libs')
    end

    it 'installs package postgresql-server' do
      expect(chef_run).to install_package('postgresql-server')
    end

    it 'installs package postgresql-contrib' do
      expect(chef_run).to install_package('postgresql-contrib')
    end

    it 'installs package postgresql-devel' do
      expect(chef_run).to install_package('postgresql-devel')
    end

    describe 'execute postgres setup command' do
      it 'installs new postgresql database cluster' do
        expect(chef_run).to run_execute('postgresql-setup initdb').
          with(user: 'root', cwd: '/opt')
      end
    end
  end
end
