# # encoding: utf-8

# Inspec test for recipe git::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
#

describe package('git-all') do
  it { should be_installed }
end

describe file('/home/vagrant/.gitconfig') do
  it { should exist }
  it { should be_file }

  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }

  it { should be_writable.by_user('vagrant') }
  it { should be_readable.by_user('vagrant') }

  it { should_not be_executable }
  it { should_not be_writable.by_user('some_random_user') }
end
