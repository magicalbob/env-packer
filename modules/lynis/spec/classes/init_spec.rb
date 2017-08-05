require 'spec_helper'
describe 'lynis' do
  context 'with default values for all parameters' do
    it { should contain_class('lynis') }
  end
end
