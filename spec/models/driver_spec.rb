require 'rails_helper'

describe Driver do
  describe 'validations' do
    it { should validate_presence_of(:address) }
  end
end