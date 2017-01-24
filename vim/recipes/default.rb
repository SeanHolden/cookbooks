#
# Cookbook:: vim
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

include_recipe 'git::default'

package 'vim-enhanced'

directory '/home/vagrant/.vim' do
  owner 'vagrant'
  group 'vagrant'
  mode '755'
end

directory '/home/vagrant/.vim/bundle' do
  owner 'vagrant'
  group 'vagrant'
  mode '755'
end

directory '/home/vagrant/.vim/colors' do
  owner 'vagrant'
  group 'vagrant'
  mode '755'
end

template '/home/vagrant/.vim/colors/monokai.vim' do
  source 'colors/monokai.vim.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '644'
end

template '/home/vagrant/.vimrc' do
  source 'vimrc.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '644'
end

# install plugins
node['vim']['plugins'].each do |plugin|
  git "/home/vagrant/.vim/bundle/#{plugin.split('/').last}" do
    repository "https://github.com/#{plugin}.git"
    user 'vagrant'
    group 'vagrant'
    environment ({ 'HOME' => '/home/vagrant', 'USER' => 'vagrant' })
    timeout 10
  end
end
