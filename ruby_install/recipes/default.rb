#
# Cookbook:: ruby_install
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

version = node['ruby_install']['version']
install_dir = node['ruby_install']['install_dir']

remote_file "#{install_dir}/ruby-install-#{version}.tar.gz" do
  source "https://github.com/postmodern/ruby-install/archive/v#{version}.tar.gz"
end

execute 'extract tar gz file' do
  command "tar -xzvf ruby-install-#{version}.tar.gz"
  cwd install_dir
  creates "#{install_dir}/ruby-install-#{version}"
end

file "#{install_dir}/ruby-install-#{version}.tar.gz" do
  action :delete
end

execute 'run Makefile' do
  command "make install"
  cwd "#{install_dir}/ruby-install-#{version}"
  creates "/usr/local/bin/ruby-install"
end
