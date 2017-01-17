#
# Cookbook:: chruby
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'chruby::default' do
  context 'When all attributes are default, on centos7 platform' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:install_dir) { '/opt' }
    let(:chruby_version) { '0.3.9' }
    let(:source_file) { "chruby-#{chruby_version}.tar.gz" }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    describe 'remote file download' do
      it 'downloads correct zipped tarball file to /opt' do
        expect(chef_run).to create_remote_file("/opt/#{source_file}")
      end
    end

    describe 'extract tar gz file' do
      it 'runs correct command' do
        expect(chef_run).to run_execute(
          "tar -xzvf #{source_file}"
        ).with(cwd: install_dir)
      end
    end

    describe 'delete tar gz file' do
      it 'removes tar.gz file after extracting' do
        expect(chef_run).to delete_file("#{install_dir}/#{source_file}")
      end
    end

    describe 'run chruby Makefile' do
      it 'runs correct command' do
        expect(chef_run).to run_execute(
          "make install"
        ).with(cwd: "#{install_dir}/chruby-#{chruby_version}")
      end
    end

    describe '.bashrc file' do
      it 'adds .bashrc file content correctly' do
        expect(chef_run).to create_template('/home/vagrant/.bashrc').with(
          user: 'vagrant',
          group: 'vagrant',
          mode: '644',
        )
      end
    end
  end
end
