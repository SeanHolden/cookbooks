#
# Cookbook:: ruby
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

include_recipe "ruby_install::default"

rubies_dir = node['ruby']['rubies_dir']

node['ruby']['versions'].each do |version|
  execute "Install ruby #{version}" do
    cwd '/home/vagrant'
    environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
    user 'vagrant'
    creates "#{rubies_dir}/ruby-#{version}/bin/ruby"
    command "ruby-install --rubies-dir #{rubies_dir} ruby #{version}"
  end
end
