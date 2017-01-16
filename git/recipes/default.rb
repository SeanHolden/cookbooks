#
# Cookbook:: git
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.
#

package 'git-all'

template '/home/vagrant/.gitconfig' do
  source 'gitconfig.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '644'
end
