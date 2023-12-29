require 'rails_helper'

describe 'Time And Distance Conversion Service' do
  before :each do
     @duration_to_convert = 113
     @distance_to_convert = 531
  end

  it 'can convert seconds into hours', :vcr do
    conversion_service = TimeAndDistanceConversionService.new(@duration_to_convert)
    converted_value = conversion_service.convert_seconds_to_hours

    expect(converted_value).to be_an(String)
    expect(converted_value).to eq("0.03")

    expect(converted_value).not_to be_an(Float)
    expect(converted_value).not_to eq(0.03)
  end

  it 'can convert seconds into hours', :vcr do
    conversion_service = TimeAndDistanceConversionService.new(@distance_to_convert)
    converted_value = conversion_service.convert_meters_to_miles

    expect(converted_value).to be_an(String)
    expect(converted_value).to eq("0.33")

    expect(converted_value).not_to be_an(Float)
    expect(converted_value).not_to eq(0.33)
  end
end