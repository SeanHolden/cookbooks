# # encoding: utf-8

# Inspec test for recipe postgresql::default

describe package('postgresql') do
  it { should be_installed }
end

describe package('postgresql-libs') do
  it { should be_installed }
end

describe package('postgresql-server') do
  it { should be_installed }
end

describe package('postgresql-contrib') do
  it { should be_installed }
end

describe package('postgresql-devel') do
  it { should be_installed }
end

describe service('postgresql') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/var/lib/pgsql/data/pg_hba.conf') do
  it { should exist }

  it { should be_owned_by('postgres') }

  it { should be_readable.by('owner') }
  it { should be_writable.by('owner') }
  it { should_not be_executable.by('owner') }

  it { should_not be_readable.by('group') }
  it { should_not be_writable.by('group') }
  it { should_not be_executable.by('group') }

  it { should_not be_readable.by_user('vagrant') }
  it { should_not be_writable.by_user('vagrant') }
  it { should_not be_executable.by_user('vagrant') }
end
