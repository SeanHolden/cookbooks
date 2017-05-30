#
# Cookbook:: postgresql
# Recipe:: app_setup
# For setting up a database ready for use in a web app
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.
#
execute 'Create new psql user' do
  db_user = node['postgresql']['db_user']
  db_password = node['postgresql']['db_password']

  user 'root'
  exists = "sudo -u postgres psql -c \"SELECT * FROM pg_user WHERE usename='#{db_user}'\" | grep -c #{db_user}"

  command "sudo -u postgres psql -c \"CREATE USER #{db_user} WITH PASSWORD '#{db_password}';\""
  not_if exists
end

execute 'Create new database' do
  db_name = node['postgresql']['db_name']

  user 'root'
  exists = "sudo -u postgres psql -c \"SELECT * FROM pg_database WHERE datname='#{db_name}'\" | grep -c #{db_name}"

  command "sudo -u postgres psql -c \"CREATE DATABASE #{db_name};\""
  not_if exists
end

execute 'Create new test database' do
  db_name = node['postgresql']['db_name']

  user 'root'
  exists = "sudo -u postgres psql -c \"SELECT * FROM pg_database WHERE datname='#{db_name}_test'\" | grep -c #{db_name}_test"

  command "sudo -u postgres psql -c \"CREATE DATABASE #{db_name}_test;\""
  not_if exists
end

execute 'Grant all privileges on database to user' do
  db_name = node['postgresql']['db_name']
  db_user = node['postgresql']['db_user']

  user 'root'
  has_permissions = "sudo -u postgres psql -c \"SELECT has_database_privilege('#{db_user}', '#{db_name}', 'CREATE');\" | grep -c \"^ t$\""

  command "sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE #{db_name} to #{db_user}\""
  not_if has_permissions
end

execute 'Grant all privileges on test database to user' do
  db_name = node['postgresql']['db_name']
  db_user = node['postgresql']['db_user']

  user 'root'
  has_permissions = "sudo -u postgres psql -c \"SELECT has_database_privilege('#{db_user}', '#{db_name}_test', 'CREATE');\" | grep -c \"^ t$\""

  command "sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE #{db_name}_test to #{db_user}\""
  not_if has_permissions
end
