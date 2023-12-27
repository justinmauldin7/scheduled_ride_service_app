require 'rails_helper'

describe Ride do
  describe 'relationships' do
    it { should belong_to(:driver) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_address) }
    it { should validate_presence_of(:end_address) }
  end
end