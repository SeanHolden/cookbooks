#
# Cookbook:: git
# Spec:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

require 'spec_helper'

describe 'git::default' do
  context 'When all attributes are default, on centos7 platform' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs git package' do
      expect(chef_run).to install_package('git-all')
    end

    it 'creates .gitconfig in home directory' do
      expect(chef_run).to create_template('/home/vagrant/.gitconfig').with(
        user: 'vagrant',
        group: 'vagrant',
        mode: '644'
      )
    end
  end
end
