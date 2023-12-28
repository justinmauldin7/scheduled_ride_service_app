require 'rails_helper'

describe 'Rides API' do
  before :each do
    @driver = Driver.create(address: "12051 E Arizona Ave. Aurora, CO 80012")

    @ride_1 = Ride.create(driver: @driver, 
            start_address:"12200 E Mississippi Ave, Aurora, CO 80012",
            end_address:"1550 S Potomac St, Aurora, CO 80012")

    @ride_2 = Ride.create(driver: @driver, 
                start_address:"12200 E Mississippi Ave, Aurora, CO 80012", 
                end_address:"200 S Ironton St, Aurora, CO 80012")

    @ride_3 = Ride.create(driver: @driver, 
                start_address:"12200 E Mississippi Ave, Aurora, CO 80012", 
                end_address:"8580 E Lowry Blvd, Denver, CO 80230")

    @ride_4 = Ride.create(driver: @driver, 
                start_address:"12051 E Arizona Ave. Aurora, CO 80012", 
                end_address:"8580 E Lowry Blvd, Denver, CO 80230")
  end

  it "can return a specific Driver's associated rides" do
    get "/api/v1/drivers/#{@driver.id}/rides"

    rides = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(rides.count).to eq(@driver.rides.size)

    rides.each do |ride|
      expect(ride).to have_key(:id)
      expect(ride[:id]).to be_an(Integer)

      expect(ride).to have_key(:driver_id)
      expect(ride[:driver_id]).to eq(@driver.id)

      expect(ride).to have_key(:start_address)
      expect(ride[:start_address]).to be_a(String)

      expect(ride).to have_key(:end_address)
      expect(ride[:end_address]).to be_a(String)

      expect(ride).to have_key(:created_at)
      expect(ride[:created_at]).to be_a(String)

      expect(ride).to have_key(:updated_at)
      expect(ride[:updated_at]).to be_a(String)
    end
  end
end