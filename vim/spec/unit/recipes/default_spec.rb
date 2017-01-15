#
# Cookbook:: vim
# Spec:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

require 'spec_helper'

describe 'vim::default' do

  context 'When all attributes are default, on CentOS' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs vim' do
      expect(chef_run).to install_package('vim-enhanced')
    end
  end
end
