#
# Cookbook:: gcc
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'gcc::default' do
  context 'When all attributes are default, on centos7' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    describe 'package' do
      it 'installs gcc' do
        expect(chef_run).to install_package('gcc-c++.x86_64')
      end
    end
  end
end
