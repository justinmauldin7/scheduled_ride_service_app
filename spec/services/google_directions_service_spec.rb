require 'rails_helper'

describe GoogleDirectionsService do
  let(:driver_address) { "12051 E Arizona Ave. Aurora, CO 80012" }
  let(:ride_start_address) { "12200 E Mississippi Ave, Aurora, CO 80012" }
  let(:ride_end_address) { "1550 S Potomac St, Aurora, CO 80012" }
  
  it 'can get raw directions data', :vcr do
    api_response = GoogleDirectionsService.get_raw_directions_data(driver_address, ride_start_address, ride_end_address)

    api_response_driver_address = api_response[:routes].first[:legs].first[:start_address]
    api_response_start_address = api_response[:routes].first[:legs].last[:start_address]
    api_response_end_address = api_response[:routes].first[:legs].last[:end_address]

    expect(api_response[:status]).to eq("OK")
    # This expect is written different because the driver's address as it is saved to the driver record in the db,
    # might not be the same format that is returned by the Google Directions API response.
    expect(driver_address).to start_with(api_response_driver_address.split(",").first)
    expect(api_response_start_address).to include(ride_start_address)
    expect(api_response_end_address).to include(ride_end_address)
  end

  it 'can get cleaned directions data', :vcr do
    ride_data = GoogleDirectionsService.get_serialized_directions_data(driver_address, ride_start_address, ride_end_address)

    ride_data.each do |ride|
      expect(ride).to have_key(:distance)
      expect(ride[:distance]).to be_an(Hash)

      expect(ride[:distance]).to have_key(:text)
      expect(ride[:distance][:text]).to be_an(String)

      expect(ride[:distance]).to have_key(:value)
      expect(ride[:distance][:value]).to be_an(Integer)

      expect(ride).to have_key(:duration)
      expect(ride[:duration]).to be_an(Hash)

      expect(ride[:duration]).to have_key(:text)
      expect(ride[:duration][:text]).to be_an(String)
      
      expect(ride[:duration]).to have_key(:value)
      expect(ride[:duration][:value]).to be_an(Integer)
    end
  end

  it 'can get cleaned distance & direction data (for ride routing)', :vcr do
    ride_data = GoogleDirectionsService.get_cleaned_ride_routing_data(driver_address, ride_start_address, ride_end_address)

    ride_data.each do |ride|
      expect(ride.keys).to eq([:distance, :duration])
      
      expect(ride).to have_key(:distance)
      expect(ride[:distance]).to be_an(Integer)

      expect(ride).to have_key(:duration)
      expect(ride[:duration]).to be_an(Integer)
    end
  end
end