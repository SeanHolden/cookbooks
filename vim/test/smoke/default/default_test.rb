describe package('vim-enhanced') do
  it { should be_installed }
end

describe directory('/home/vagrant/.vim') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}
  its('mode') { should eql('755') }
end

describe directory('/home/vagrant/.vim/bundle') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}
  its('mode') { should eql('755') }
end

describe directory('/home/vagrant/.vim/colors') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}
  its('mode') { should eql('755') }
end

describe file('/home/vagrant/.vim/colors/monokai.vim') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}
  its('mode') { should eql('644') }
  its('md5sum') { should eql('a132c852155fafe19d2a6a1f3d9c4e1f') }
end

describe file('/home/vagrant/.vimrc') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}
  its('mode') { should eql('644') }
  its('md5sum') { should eql('a8704115dbc155eefc099eae06dc7af5') }
end

# if this file exists, then vundle ran successfully
describe file('/home/vagrant/.vim/bundle/nerdtree/README.markdown') do
  it { should exist }
end
