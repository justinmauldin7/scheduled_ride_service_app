require 'rails_helper'

describe RideScoreCalculatorService do
  let(:driver_address) { "12051 E Arizona Ave. Aurora, CO 80012" }
  let(:ride_start_address) { "12200 E Mississippi Ave, Aurora, CO 80012" }
  let(:ride_end_address) { "1550 S Potomac St, Aurora, CO 80012" }

  it "can get a Ride's score", :vcr do
    cleaned_route_data = RoutingService.get_cleaned_ride_routing_data(driver_address, ride_start_address, ride_end_address)

    ride_score_service = RideScoreCalculatorService.new(cleaned_route_data)
    ride_score = ride_score_service.get_ride_score

    expect(ride_score).to be_an(String)
    expect(ride_score).to eq("100.53")

    expect(ride_score).not_to be_an(Float)
    expect(ride_score).not_to eq(100.53)
  end
end
