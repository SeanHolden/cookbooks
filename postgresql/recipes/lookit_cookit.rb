execute 'Create new psql user' do
  db_user = node['postgresql']['db_user']
  db_password = node['postgresql']['db_password']

  user 'root'
  already_setup = "sudo -u postgres psql -tAc \"SELECT 1 FROM pg_roles WHERE rolname='#{db_user}'\" | grep 1"
  not_if already_setup

  command "sudo -u postgres psql -c \"CREATE USER #{db_user} WITH PASSWORD '#{db_password}';\""
end
