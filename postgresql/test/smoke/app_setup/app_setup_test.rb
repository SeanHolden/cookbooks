# # encoding: utf-8

# Inspec test for recipe postgresql::app_setup

describe bash("sudo -u postgres psql -c \"SELECT has_database_privilege('test_db_user', 'test_db_name', 'CREATE');\" | grep -c \"^ t$\"") do
  its('stdout') { should eq("1\n") }
end
