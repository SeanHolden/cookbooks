#
# Cookbook:: vim
# Spec:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

require 'spec_helper'

describe 'vim::default' do
  context 'When all attributes are default, on CentOS' do
    subject(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs vim' do
      expect(chef_run).to install_package('vim-enhanced')
    end

    describe '#directories' do
      it 'creates ~/.vim' do
        expect(chef_run).to create_directory('/home/vagrant/.vim').
          with(
            owner: 'vagrant',
            group: 'vagrant',
            mode: '755'
          )
      end

      it 'creates ~/.vim/bundle' do
        expect(chef_run).to create_directory('/home/vagrant/.vim/bundle').
          with(
            owner: 'vagrant',
            group: 'vagrant',
            mode: '755'
          )
      end

      it 'creates ~/.vim/colors' do
        expect(chef_run).to create_directory('/home/vagrant/.vim/colors').
          with(
            owner: 'vagrant',
            group: 'vagrant',
            mode: '755'
          )
      end
    end

    describe '#templates' do
      it 'creates ~/.vim/colors/monokai.vim' do
        expect(chef_run).to create_template('/home/vagrant/.vim/colors/monokai.vim').
          with(
            owner: 'vagrant',
            group: 'vagrant',
            mode: '644'
          )
      end

      it 'creates ~/.vimrc' do
        expect(chef_run).to create_template('/home/vagrant/.vimrc').
          with(
            owner: 'vagrant',
            group: 'vagrant',
            mode: '644'
          )
      end
    end

    describe '#git' do
      it 'checkout/sync Vundle repo' do
        expect(chef_run).to sync_git('/home/vagrant/.vim/bundle/Vundle.vim').
          with(
            repository: 'https://github.com/VundleVim/Vundle.vim.git',
            user: 'vagrant',
            group: 'vagrant',
            environment: { 'HOME' => '/home/vagrant', 'USER' => 'vagrant' },
            timeout: 10
          )
      end

      it 'checkout/sync ctrlp repo' do
        expect(chef_run).to sync_git('/home/vagrant/.vim/bundle/ctrlp.vim').
          with(
            repository: 'https://github.com/kien/ctrlp.vim.git',
            user: 'vagrant',
            group: 'vagrant',
            environment: { 'HOME' => '/home/vagrant', 'USER' => 'vagrant' },
            timeout: 10
          )
      end

      it 'checkout/sync nerdtree repo' do
        expect(chef_run).to sync_git('/home/vagrant/.vim/bundle/nerdtree').
          with(
            repository: 'https://github.com/scrooloose/nerdtree.git',
            user: 'vagrant',
            group: 'vagrant',
            environment: { 'HOME' => '/home/vagrant', 'USER' => 'vagrant' },
            timeout: 10
          )
      end

      it 'checkout/sync tlib repo' do
        expect(chef_run).to sync_git('/home/vagrant/.vim/bundle/tlib_vim').
          with(
            repository: 'https://github.com/tomtom/tlib_vim.git',
            user: 'vagrant',
            group: 'vagrant',
            environment: { 'HOME' => '/home/vagrant', 'USER' => 'vagrant' },
            timeout: 10
          )
      end

      it 'checkout/sync vim-better-whitespace repo' do
        expect(chef_run).to sync_git('/home/vagrant/.vim/bundle/vim-better-whitespace').
          with(
            repository: 'https://github.com/ntpeters/vim-better-whitespace.git',
            user: 'vagrant',
            group: 'vagrant',
            environment: { 'HOME' => '/home/vagrant', 'USER' => 'vagrant' },
            timeout: 10
          )
      end

      it 'checkout/sync vim-snipmate repo' do
        expect(chef_run).to sync_git('/home/vagrant/.vim/bundle/vim-snipmate').
          with(
            repository: 'https://github.com/garbas/vim-snipmate.git',
            user: 'vagrant',
            group: 'vagrant',
            environment: { 'HOME' => '/home/vagrant', 'USER' => 'vagrant' },
            timeout: 10
          )
      end
    end
  end
end
