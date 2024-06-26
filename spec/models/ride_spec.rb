require 'rails_helper'

describe Ride do
  describe 'relationships' do
    it { should belong_to(:driver) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_address) }
    it { should validate_presence_of(:end_address) }
  end

  describe 'instance methods' do
    let(:driver) { Driver.create(address: "12051 E Arizona Ave. Aurora, CO 80012") }

    let(:ride) do
        Ride.create(driver: driver, 
                    start_address:"12200 E Mississippi Ave, Aurora, CO 80012",
                    end_address:"1550 S Potomac St, Aurora, CO 80012")
    end

    it 'can set the score field on a ride record', :vcr do
      cleaned_route_data = RoutingService.get_cleaned_ride_routing_data(driver.address, ride.start_address, ride.end_address)

      ride_score_service = RideScoreCalculatorService.new(cleaned_route_data)
      expected_ride_score = ride_score_service.get_ride_score.to_f

      expect(ride.score).to eq(expected_ride_score)
      expect(ride.score).not_to eq(nil)
    end

    it 'can prevent trying to set the ride score on a record if it already has one', :vcr do
      expect { ride.set_ride_score }.to raise_error(StandardError, "ERROR: Ride score is already set.")
    end
  end  
end