#
# Cookbook:: chruby
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

version = node['chruby']['version']
install_dir = node['chruby']['install_dir']

remote_file "#{install_dir}/chruby-#{version}.tar.gz" do
  source "https://github.com/postmodern/chruby/archive/v#{version}.tar.gz"
end

execute 'extract tar gz file' do
  command "tar -xzvf chruby-#{version}.tar.gz"
  cwd install_dir
  creates "#{install_dir}/chruby-#{version}"
end

file "#{install_dir}/chruby-#{version}.tar.gz" do
  action :delete
end

execute 'run Makefile' do
  command "make install"
  cwd "#{install_dir}/chruby-#{version}"
  creates "/usr/local/share/chruby/chruby.sh"
end

template '/home/vagrant/.bashrc' do
  source 'bashrc.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '644'
end
