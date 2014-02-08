require 'spec_helper'
describe 'systemd::service_file', :type => :define do
  let(:title) { 'foo' }

  context 'with an invalid type' do
    let(:params) { {'type' => 'bacon' } }
    it do
      expect {
        should contain_file('foo.service')
      }.to raise_error(Puppet::Error, /^Unknown type/)
    end
  end

  context 'with an invalid restart' do
    let(:params) { {
      'type' => 'oneshot',
      'restart' => 'bacon' } }
    it do
      expect {
        should contain_file('foo.service')
      }.to raise_error(Puppet::Error, /^Unknown restart/)
    end
  end


  context 'missing execstart' do
    let(:params) { {
      'type' => 'forking'
    } }
    it do
      expect {
        should contain_file('foo.service')
      }.to raise_error(Puppet::Error, /^forking requires execstart.*/)
    end
  end

end
