require 'rails_helper'

describe 'Google Directions API Service' do
  it 'can get directions', :vcr do
    driver = Driver.create(address: "12051 E Arizona Ave. Aurora, CO 80012")

    ride = Ride.create(driver: driver, 
            start_address:"12200 E Mississippi Ave, Aurora, CO 80012",
            end_address:"1550 S Potomac St, Aurora, CO 80012")

    api_response = GoogleDirectionsService.get_directions_data(driver.address, ride.start_address, ride.end_address)

    api_response_driver_address = api_response[:routes].first[:legs].first[:start_address]
    api_response_start_address = api_response[:routes].first[:legs].last[:start_address]
    api_response_end_address = api_response[:routes].first[:legs].last[:end_address]

    expect(api_response[:status]).to eq("OK")
    # This expect is written different because the driver's address as it is saved to the driver record in the db,
    # might not be the same format that is returned by the Google Directions API response.
    expect(driver.address).to start_with(api_response_driver_address.split(",").first)
    expect(api_response_start_address).to include(ride.start_address)
    expect(api_response_end_address).to include(ride.end_address)
  end
end