# # encoding: utf-8

# Inspec test for recipe ruby_install::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/opt/ruby-install-0.6.1.tar.gz') do
  it { should_not exist }
end

describe file('/opt/ruby-install-0.6.1') do
  it { should exist }
end

describe file('/usr/local/bin/ruby-install') do
  it { should exist }
  it { should be_executable }
end
