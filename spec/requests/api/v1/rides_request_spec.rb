require 'rails_helper'

describe 'Rides API' do
  let!(:driver) { Driver.create(address: "12051 E Arizona Ave. Aurora, CO 80012") }


  let!(:ride_1) do 
    Ride.create(driver: driver, 
                start_address:"12200 E Mississippi Ave, Aurora, CO 80012", 
                end_address:"8580 E Lowry Blvd, Denver, CO 80230")
  end

  let!(:ride_2) do 
    Ride.create(driver: driver, 
                start_address:"12200 E Mississippi Ave, Aurora, CO 80012", 
                end_address:"200 S Ironton St, Aurora, CO 80012")
  end

  let!(:ride_3) do 
    Ride.create(driver: driver, 
            start_address:"12200 E Mississippi Ave, Aurora, CO 80012",
            end_address:"1550 S Potomac St, Aurora, CO 80012")
  end

  let!(:ride_4) do 
    Ride.create(driver: driver, 
                start_address:"12051 E Arizona Ave. Aurora, CO 80012", 
                end_address:"8580 E Lowry Blvd, Denver, CO 80230")
  end

  it "can return a specific Driver's associated rides", :vcr do
    get "/api/v1/drivers/#{driver.id}/rides"

    rides = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(rides.count).to eq(driver.rides.size)

    rides.each do |ride|
      expect(ride).to have_key(:id)
      expect(ride[:id]).to be_an(Integer)

      expect(ride).to have_key(:driver_id)
      expect(ride[:driver_id]).to eq(driver.id)

      expect(ride).to have_key(:start_address)
      expect(ride[:start_address]).to be_a(String)

      expect(ride).to have_key(:end_address)
      expect(ride[:end_address]).to be_a(String)

      expect(ride).to have_key(:created_at)
      expect(ride[:created_at]).to be_a(String)

      expect(ride).to have_key(:updated_at)
      expect(ride[:updated_at]).to be_a(String)

      expect(ride).to have_key(:score)
      expect(ride[:score]).to be_a(Float)
    end
  end

  it "can return rides ordered by its score", :vcr do
    get "/api/v1/drivers/#{driver.id}/rides"

    rides = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(rides.first[:id]).to eq(ride_3.id)
    expect(rides.first[:score]).to eq(ride_3.score)
    
    expect(rides.first[:id]).not_to eq(ride_2.id)
    expect(rides.first[:score]).not_to eq(ride_2.score)

    expect(rides.last[:id]).to eq(ride_1.id)
    expect(rides.last[:score]).to eq(ride_1.score)
    
    expect(rides.last[:id]).not_to eq(ride_4.id)
    expect(rides.last[:score]).not_to eq(ride_4.score)
  end

  it "can return a paginated list of a specific Driver's associated rides", :vcr do
    per_page_number = 2
    page_number = 1

    get "/api/v1/drivers/#{driver.id}/rides?per_page=#{per_page_number}&page=#{page_number}"

    rides = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(rides.count).to eq(per_page_number)
    expect(rides.count).not_to eq(4)

    expect(rides.first[:id]).to eq(ride_3.id)
    expect(rides.first[:id]).not_to eq(ride_2.id)
    
    expect(rides.last[:id]).to eq(ride_2.id)
    expect(rides.last[:id]).not_to eq(ride_4.id)
  end
end