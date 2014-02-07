require 'spec_helper'

describe 'systemd', :type => :class do
  let(:facts) { {
    :operatingsystem            => 'RedHat',
    :operatingsystemmajorelease => '7',
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

end
