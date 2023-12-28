require 'rails_helper'

describe 'Google Directions API Service' do
  it 'can get directions', :vcr do
    driver = Driver.create(address: "12051 E Arizona Ave. Aurora, CO 80012")

    ride = Ride.create(driver: driver, 
            start_address:"12200 E Mississippi Ave, Aurora, CO 80012",
            end_address:"1550 S Potomac St, Aurora, CO 80012")
          
    goodle_directions = GoogleDirectionsService.new(ride.start_address, ride.end_address)
    api_response = google_directions.get_directions_data

    expect(api_response).to eq("Success")
    expect(api_response).to include(ride.start_address)
    expect(api_response).to include(ride.end_address)
  end
end