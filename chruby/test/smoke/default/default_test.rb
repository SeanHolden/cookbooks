describe file('/opt/chruby-0.3.9.tar.gz') do
  it { should_not exist }
end

describe file('/opt/chruby-0.3.9') do
  it { should exist }
end

describe file('/usr/local/share/chruby/chruby.sh') do
  it { should exist }
end

describe file('/usr/local/share/chruby/auto.sh') do
  it { should exist }
end

describe file('/home/vagrant/.bashrc') do
  its('content') { should match(%r{source \/usr\/local\/share\/chruby\/chruby\.sh}) }
  its('content') { should match(%r{source \/usr\/local\/share\/chruby\/auto\.sh}) }
end
