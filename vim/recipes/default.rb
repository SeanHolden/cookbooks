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

git '/home/vagrant/.vim/bundle' do
  repository 'git://github.com/VundleVim/Vundle.vim.git'
  revision 'master'
  user 'vagrant'
  group 'vagrant'
end

execute 'Install/Update all vim plugins' do
  user 'vagrant'
  cwd '/home/vagrant'
  command 'vim +PluginInstall +qall'
end
