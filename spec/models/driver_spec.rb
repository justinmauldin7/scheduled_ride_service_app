require 'rails_helper'

describe Driver do
  describe 'relationships' do
    it { should have_many(:drives) }
  end

  describe 'validations' do
    it { should validate_presence_of(:address) }
  end
end