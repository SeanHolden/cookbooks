#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

package 'epel-release'
package 'nginx'

directory '/var/www' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end

link '/var/www/html' do
  to '/vagrant'
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'nginx' do
  action [:enable, :start]
end
