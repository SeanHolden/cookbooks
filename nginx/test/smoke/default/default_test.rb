describe user('root') do
  it { should exist }
end

describe user('vagrant') do
  it { should exist }
end

describe package('epel-release') do
  it { should be_installed }
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

describe directory('/var/www') do
  it { should exist }
  it { should be_directory }
  it { should be_owned_by('vagrant') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by_user('vagrant') }
  it { should be_writable.by('owner') }
  it { should_not be_writable.by('group') }
  it { should_not be_writable.by_user('some_user') }
end

describe directory('/var/www/html') do
  it { should be_symlink }
  it { should be_linked_to '/vagrant' }
end

describe file('/etc/nginx/nginx.conf') do
  it { should exist }
  it { should be_file }

  it { should be_owned_by('root') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by_user('vagrant') }

  it { should be_writable.by('owner') }
  it { should_not be_writable.by('group') }
  it { should_not be_writable.by_user('vagrant') }

  its('md5sum') { should eq 'c9338c97c1589dcb06eb94a0eae6ba4f' }
end
