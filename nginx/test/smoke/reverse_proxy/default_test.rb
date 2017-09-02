describe user('root') do
  it { should exist }
end

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/nginx/sites-available/default') do
  it { should exist }
  it { should be_file }

  it { should be_owned_by('root') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by_user('ubuntu') }

  it { should be_writable.by('owner') }
  it { should_not be_writable.by('group') }
  it { should_not be_writable.by_user('ubuntu') }

  its('md5sum') { should eq 'db48c498edbb3835987a1f14a6e6af0d' }
end
