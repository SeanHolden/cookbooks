#
# Cookbook:: ruby
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ruby::default' do
  context 'When all attributes are default, on Centos7.2' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    describe 'install ruby' do
      let(:rubies_dir) { '/home/vagrant/.rubies' }
      let(:ruby_version) { '2.4.0' }

      it 'runs correct command' do
        expect(chef_run).to run_execute(
          "ruby-install --rubies-dir #{rubies_dir} ruby #{ruby_version}"
        ).
        with(
          cwd: '/home/vagrant',
          environment: { 'HOME' => '/home/vagrant', 'USER' => 'vagrant'},
          user: 'vagrant'
        )
      end
    end
  end
end
