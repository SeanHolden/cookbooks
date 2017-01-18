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
  end
end
