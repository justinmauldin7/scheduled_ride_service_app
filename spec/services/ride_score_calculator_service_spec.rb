require 'rails_helper'

describe 'Ride Score Calculator Service' do
  before :each do
    @driver = Driver.create(address: "12051 E Arizona Ave. Aurora, CO 80012")

    @ride = Ride.create(driver: @driver, 
            start_address:"12200 E Mississippi Ave, Aurora, CO 80012",
            end_address:"1550 S Potomac St, Aurora, CO 80012")
  end

  it "can get a Ride's score", :vcr do
    cleaned_route_data = GoogleDirectionsService.get_cleaned_ride_routing_data(@driver.address, @ride.start_address, @ride.end_address)

    ride_score_service = RideScoreCalculatorService.new(cleaned_route_data)
    ride_score = ride_score_service.get_ride_score

    expect(ride_score).to be_an(String)
    expect(ride_score).to eq("100.74")

    expect(ride_score).not_to be_an(Float)
    expect(ride_score).not_to eq(100.74)
  end
end
