require 'spec_helper'

describe 'systemd', :type => :class do
  let(:facts) { {
    :operatingsystem        => 'RedHat',
    :operatingsystemrelease => '7.0',
  } }
  it { should compile.with_all_deps }

  context 'with an invalid distro name' do
    let(:facts) { {:operatingsystem => 'Debian'} }
    it do
      expect {
        should contain_package('systemd')
      }.to raise_error(Puppet::Error, /^Debian is not supported/)
    end
  end

  context 'with an invalid rhel version' do
    let(:facts) { {
      :operatingsystem => 'RedHat',
      :operatingsystemrelease => '6.5',
    } }
    it do
      expect {
        should contain_package('systemd')
      }.to raise_error(Puppet::Error, /^RedHat operating systems must be at least.*/)
    end
  end

end
