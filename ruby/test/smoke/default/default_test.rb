describe file('/home/vagrant/.rubies/ruby-2.4.0/bin/ruby') do
  it { should exist }
  it { should be_executable }
end

describe file('/home/vagrant/.rubies/ruby-2.4.0/bin/irb') do
  it { should exist }
  it { should be_executable }
end
