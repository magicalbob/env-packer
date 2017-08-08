require 'spec_helper'
describe 'sudoers' do
  context 'with default values for all parameters' do
    it { should contain_class('sudoers') }
  end
end
