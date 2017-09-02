#
# Cookbook:: nginx
# Recipe:: reverse_proxy
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

package 'epel-release' if platform?('centos')
package 'nginx'

template '/etc/nginx/sites-available/default' do
  source 'sites-available/default.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'nginx' do
  action [:enable, :start]
end
