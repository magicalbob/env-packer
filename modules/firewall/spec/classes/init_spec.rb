require 'spec_helper'
describe 'firewall' do
  context 'with default values for all parameters' do
    it { should contain_class('firewall') }
  end
end
