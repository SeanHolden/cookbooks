describe package('vim-enhanced') do
  it { should be_installed }
end

describe directory('/home/vagrant/.vim') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}

  it { should be_readable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_executable.by('owner') }

  it { should be_readable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_executable.by('group') }
end

describe directory('/home/vagrant/.vim/bundle') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}

  it { should be_readable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_executable.by('owner') }

  it { should be_readable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_executable.by('group') }
end

describe directory('/home/vagrant/.vim/colors') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}

  it { should be_readable.by('owner') }
  it { should be_writable.by('owner') }
  it { should be_executable.by('owner') }

  it { should be_readable.by('group') }
  it { should_not be_writable.by('group') }
  it { should be_executable.by('group') }
end

describe file('/home/vagrant/.vim/colors/monokai.vim') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}
  its('md5sum') { should eql('4a5c9bb75efdf7f6fca505261ab4167a') }

  it { should be_readable.by('owner') }
  it { should be_writable.by('owner') }
  it { should_not be_executable.by('owner') }

  it { should be_readable.by('group') }
  it { should_not be_writable.by('group') }
  it { should_not be_executable.by('group') }
end

describe file('/home/vagrant/.vimrc') do
  it { should exist }
  it { should be_owned_by('vagrant')}
  it { should be_grouped_into('vagrant')}

  it { should be_readable.by('owner') }
  it { should be_writable.by('owner') }
  it { should_not be_executable.by('owner') }

  it { should be_readable.by('group') }
  it { should_not be_writable.by('group') }
  it { should_not be_executable.by('group') }
end

describe directory('/home/vagrant/.vim/bundle/nerdtree') do
  it { should exist }
end
