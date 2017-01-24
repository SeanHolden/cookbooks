#
# Cookbook:: postgresql
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

package 'postgresql'
package 'postgresql-libs'
package 'postgresql-server'
package 'postgresql-contrib'

execute 'create new postgresql database cluster' do
  cwd '/opt'
  user 'root'
  command "postgresql-setup initdb"
  already_setup = 'sudo -u postgres psql -c "SELECT * FROM pg_user" | grep postgres'
  not_if already_setup
end

template '/var/lib/pgsql/data/pg_hba.conf' do
  source 'pg_hba.conf.erb'
  owner 'postgres'
  group 'postgres'
  mode '600'
end

service 'postgresql' do
  action [:enable, :start]
end
